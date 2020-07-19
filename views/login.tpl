%include('./header.tpl')
    <div id="contents" class="pure-u-1">
        <div class="pure-u-1">
            <h2>こんにちは，<span id="hello-user">{{username}}</span>さん</h2><br />
            <h2>ここは，<span class="marked-font">ログイン</span>用のページです．</h2>
        </div>
        
        <div class="pure-u-1">
            <img src="./static/img/login.png" class="pure-img center">
        </div>

        <form action="/login" method="post" class="form" class="pure-form pure-form-stacked">
            <div class="pure-g">
                <div class="pure-u-1">
                    <label>Username: </label>
                    <input type="text" name="username" size="20">
                </div>

                <div class="pure-u-1">
                    <label>Password: </label>
                    <input type="text" name="password" size="20">
                </div> 

                % if is_captcha == True:
                    <div class="pure-u-1">
                        <img src="./static/img/captcha.png" class="pure-img center">
                    </div>
                    <div class="pure-u-1">
                        <label for="comment">上の画像の文字を入力してください:</label>
                    </div>
                    <div class="pure-u-1">
                        <input type="text" name="captcha" size="20" maxlength="20">
                    </div>
                % end

                <div class="pure-u-1 center">
                    <button type="submit" class="pure-button pure-button-primary center">ログイン</button>
                </div>
            </div><!-- pure-g -->
        </form> <!-- login form -->

        <div class="pure-u-1 center">
            <a href="/signup"><button class="pure-button pure-button">ユーザー登録画面に戻る</button></a>
            <a href="/mypage"><button class="pure-button pure-button">マイページに行く</button></a>
            <a href="/logout"><button class="pure-button pure-button">ログアウトする</button></a>
        </div>
        
    </div><!-- contents -->

%include('./footer.tpl')
