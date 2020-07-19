
%include('./header.tpl')

    <div id="contents" class="pure-u-1">
        <div class="pure-u-1">
            <h2><span id="hello-user">{{user.username}}</span>さんが購入した商品はこちらです</h2>
        </div>
        <div class="pure-u-1-4">
            <img src="./static/img/products/{{user.random_seed1}}.png" class="pure-img">
        </div>
        <div class="pure-u-1-4">
            <img src="./static/img/products/{{user.random_seed2}}.png" class="pure-img">
        </div>
        <div class="pure-u-1-4">
            <img src="./static/img/products/{{user.random_seed3}}.png" class="pure-img">
        </div>

        <div class="pure-u-1 center">
            <a href="/bbs"><button class="pure-button pure-button">みんなの掲示板に行く</button></a>
            <a href="/login"><button class="pure-button pure-button">ログイン画面に戻る</button></a>
            <a href="/logout"><button class="pure-button pure-button">ログアウトする</button></a>
        </div>

    </div><!-- contents -->

%include('./footer.tpl')
