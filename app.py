from bottle import *
from datetime import datetime

# Set parameters
PORT=5000
CAPTCHA = True
COOKIE_SECURITY = True
XSS_SECURITY = False
DB_HASH = False

# Set a path for static files (css and javascript)
@route('/static/<filepath:path>')
def server_static( filepath ):
    return static_file( filepath, root='static' )

# Moodels class ------------------------------------------------------------------
from peewee import *
import os

DATAFILE = os.path.join(os.path.join(os.getcwd(), 'databases'), "data.db")
db = SqliteDatabase(DATAFILE)

class BaseModel(Model):
    class Meta:
        database = db

class Users(BaseModel):
    user_id = PrimaryKeyField()
    username = CharField(null=True)
    password = CharField(null=True)
    datetime = CharField(null=True)
    cookie_id = CharField(null=True)
    session_id = CharField(null=True)
    random_seed1 = IntegerField(null=True)
    random_seed2 = IntegerField(null=True)
    random_seed3 = IntegerField(null=True)

class Comments(BaseModel):
    comment_id = PrimaryKeyField()
    user = ForeignKeyField(Users, related_name='comments')
    comment = CharField(null=False)
    datetime = CharField(null=False)


# init db -----------------------------------------------------------------------
@get('/initdb')
def init_db():
    return template('initdb')

@get('/create_db')
def create_db():
    db.create_tables([Users, Comments])

    return '<html>完了しました. ブラウザから戻ってね</html>' 

@get('/init_user')
def init_user():
    import sqlite3
    conn = sqlite3.connect(DATAFILE)
    c = conn.cursor()
    sql = "DELETE FROM Uers;"
    c.execute(sql)
    conn.commit()
    conn.close()

    return '<html>完了しました. ブラウザから戻ってね</html>' 

@get('/init_comment')
def init_comment():
    import sqlite3
    conn = sqlite3.connect(DATAFILE)
    c = conn.cursor()
    sql = "DELETE FROM Comments;"
    c.execute(sql)
    conn.commit()
    conn.close()

    return '<html>完了しました. ブラウザから戻ってね</html>' 


# Controller routines ------------------------------------------------------------

def error_message(mes):
    if COOKIE_SECURITY == True:
        response.set_cookie('error', mes, secret='key')
    else:
        response.set_cookie('error', mes)


@hook('before_request')
def before():
    response.headers['Access-Control-Allow-Origin'] = "*"

@hook('after_request')
def after():
    pass

@get('/')
@get('/signup')
def index():
    return template('signup')

"""
 /signup >
 get: username
 get: password
"""
@get('/register') # for XSS
def register():
    username = request.query.username
    password = request.query.password
    return template('confirm', username=username, password=password)

"""
 /confirm >
 post: username
 post: password
"""
@post('/register')
def register():
    # Receive user information from forms
    username = request.forms.decode().get('username')
    password = request.forms.decode().get('password')

    try:
        user = Users.get(Users.username==username)
        ## 既にユーザが存在している
        error_message("User already Exist")
        redirect('/error')

    except Users.DoesNotExist:
        pass

    # Get a current time string
    now = datetime.now().strftime('%Y/%m/%d %H:%M:%S')

    # Register an account information to the database
    import random
    user = Users.create(username=username, password=password, datedate=now)
    user.random_seed1 = random.randint(1,21)
    user.random_seed2 = random.randint(1,21)
    user.random_seed3 = random.randint(1,21)
    user.save()

    redirect('/registered')

"""
 /register >
"""
@get('/registered')
def registered():
    return template('registered')

@get('/login')
def login():
    if COOKIE_SECURITY==True:
        cookie_id = request.get_cookie('cookie_id', secret='key')
    else:
        cookie_id = request.get_cookie('cookie_id')

    if cookie_id != None:
        try:
            user = Users.get(Users.cookie_id==cookie_id)
            username = user.username
        except Users.DoesNotExist: # There is not any user.
            error_message("User Does Not Exist")
            redirect('/error')
    else:
        username = "Guest"

    import random
    import string
    if CAPTCHA==True:
        captcha_text = ''.join([str(random.choice(list(range(0,10)))) for i in range(4)])

        if COOKIE_SECURITY==True:
            response.set_cookie('captcha', captcha_text, secret='key')
        else:
            response.set_cookie('captcha', captcha_text)

        from captcha.image import ImageCaptcha
        captcha_image = ImageCaptcha()
        captcha_image.write(captcha_text, './static/img/captcha.png')

    return template('login', username=username, is_captcha=CAPTCHA)

"""
 /login >
 post: username
 post: password
"""
@post('/login')
def login():
    username = request.forms.decode().get('username')
    password = request.forms.decode().get('password')
    if CAPTCHA == True:
        user_captcha = request.forms.decode().get('captcha')

        if COOKIE_SECURITY == True:
            cookie_captch = request.get_cookie('captcha', secret='key')
        else:
            cookie_captch = request.get_cookie('captcha')

        if user_captcha != cookie_captch :
            error_message("Incorrect value entered in CAPTCHA")
            redirect('/error')

    # query SQLite directly !! for SQL injection
    import sqlite3
    conn = sqlite3.connect(DATAFILE)
    c = conn.cursor()
    sql = "SELECT * FROM users WHERE username='"+username+"' and password='"+password+"'"
    for record in c.execute(sql): # SQL command
        if str(record[1]) == username:
            cookie_id = 'user'+str(record[0])
            if COOKIE_SECURITY==True:
                response.set_cookie('cookie_id', cookie_id, secret='key')
            else:
                response.set_cookie('cookie_id', cookie_id)

            update = "UPDATE users SET cookie_id='"+cookie_id+"' WHERE user_id='"+str(record[0])+"';"
            c.execute(update)
            conn.commit()
            conn.close()
            redirect('/successed')
    conn.close()

    # User Not Exist
    error_message("User Does Not Exist")
    redirect('/error')


@get('/logout')
def logout():
    response.delete_cookie('cookie_id')
    response.delete_cookie('username')
    response.delete_cookie('captcha')
    redirect('/login')

@get('/successed')
def successed():
    cookie_id = None
    username = 'Guest'

    if COOKIE_SECURITY == True:
        cookie_id = request.get_cookie('cookie_id', secret='key')
    else:
        cookie_id = request.get_cookie('cookie_id')

    if cookie_id != None :
        try:
            user = Users.get(Users.cookie_id==cookie_id)
            username = user.username
        except Users.DoesNotExist:
            error_message("User Does Not Exist")
            redirect('/error')

    return template('successed', username=username)

@get('/mypage')
def mypage():
    if COOKIE_SECURITY == True:
        cookie_id = request.get_cookie('cookie_id', secret='key')
    else:
        cookie_id = request.get_cookie('cookie_id')

    if cookie_id != None:
        try:
            user = Users.get(Users.cookie_id==cookie_id)
        except Users.DoesNotExist:
            error_message("User Does Not Exist")
            redirect('/error')
    else:
        error_message("User Does Not Exist")
        redirect('/error')

    return template('mypage', user=user)

@get('/error')
def error():
    try:
        if COOKIE_SECURITY == True:
            message = request.get_cookie('error', secret='key')
        else:
            message = request.get_cookie('error')
        response.delete_cookie('error')
    
    except:
        message = 'Unknown error'

    return template('error', message=message)


@get('/bbs') # for CSRF
def bbs():
    if COOKIE_SECURITY == True:
        cookie_id = request.get_cookie('cookie_id', secret='key')
    else:
        cookie_id = request.get_cookie('cookie_id')

    if cookie_id != None:
        try:
            user = Users.get( Users.cookie_id==cookie_id )
            username = user.username
            comments = Comments.select()
        except Users.DoesNotExist:
            error_message("User Does Not Exist")
            redirect('/error')
    else:
        error_message("CookieID Does Not Exist")
        redirect('/error')

    return template('bbs', username=username, comments=comments, xss_security=XSS_SECURITY)

@post ('/bbs') # for CSRF
def bbs():

    if COOKIE_SECURITY != True:
        cookie_id = request.get_cookie('cookie_id')
    else:
        cookie_id = request.get_cookie('cookie_id', secret='key')

    if cookie_id != None:
        try:
            user = Users.get( Users.cookie_id==cookie_id )
        except Users.DoesNotExist:
            error_message("User Does Not Exist")
            redirect('/error')
    else:
        error_message("CookieID Does Not Exist")
        redirect('/error')

    now = datetime.now().strftime('%Y/%m/%d %H:%M:%S')
    comment = request.forms.decode().get('comment')
    Comments.create(user=user, comment=comment, datetime=now)

    return template('bbs_posted')

# Main routine -------------------------------------------------------------------
if __name__ == '__main__':
    run(host="0.0.0.0", port=PORT, reloader=False, debug=True)
