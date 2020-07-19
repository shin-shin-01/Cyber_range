%include('./header.tpl')

<div id="contents" class="pure-u-1">

    <div class="pure-u-1">
        <h2>ここは，ユーザー<span class="marked-font">登録</span>用のページです．</h2>
    </div>
    <div class="pure-u-1">
        <img src="./static/img/signup.png" class="pure-img center">
    </div>

    <form action="/register" method="get" class="form" class="pure-form pure-form-stacked">
        <div class="pure-g">
            <div class="pure-u-1">
                <label for="username">Username: </label>
                <input type="text" name="username" size="20" maxlength="20">
            </div>

            <div class="pure-u-1">
                <label for="password">Password: </label>
                <input type="text" name="password" size="20" maxlength="20">
            </div>

            <div class="pure-u-1 center">
                <button type="submit" class="pure-button pure-button-primary center">登録</button>
            </div>
        </div>
    </form>

    <div class="pure-u-1 center">
        <a href="/login"><button class="pure-button pure-button">ログイン画面に戻る</button></a>
        <a href="/initdb"><button class="pure-button pure-button">データベースの初期化</button></a>
    </div>

</div>

%include('./footer.tpl')