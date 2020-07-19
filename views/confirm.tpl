%include('./header.tpl')

    <div id="contents" class="pure-u-1">
        <div class="pure-u-1">
            下記のユーザー情報で登録いたします．よろしいでしょうか？
        </div><br /><br /><br />
        <div class="pure-u-1">
            <span class="marked-font">{{username}}</span>
        </div><br /><br />

        <form action="/register" method="post" class="pure-form pure-form-stacked">
            <input type="hidden" name="username" value={{username}}>
            <input type="hidden" name="password" value={{password}}>
            <div class="pure-u-1 center">
                <button type="submit" class="pure-button pure-button-primary center">はい，この名前で登録します</button>
            </div>
        </form>

        <div class="pure-u-1 center">
            <a href="/signup"><button class="pure-button pure-button">ユーザー登録画面に戻る</button></a>
            <a href="/logout"><button class="pure-button pure-button">ログアウトする</button></a>
        </div>


    </div><!-- contents -->

%include('./footer.tpl')
