%include('./header.tpl')

    <div id="contents" class="pure-u-1">
        
        <div class="pure-u-1">
            <h2>こんにちは，<span id="hello-user">{{username}}</span>さん</h2>
        </div>
        <div class="pure-u-1">
            <h2>こんにちは，<span class="marked-font">ログインできました！</span></h2>
        </div>

        <div class="pure-u-1">
            <img src="./static/img/successed.png" class="pure-img center">
        </div>

        <div class="pure-u-1 center">
            <a href="/mypage"><button class="pure-button pure-button">マイページに行く</button></a>
            <a href="/login"><button class="pure-button pure-button">ログイン画面に戻る</button></a>
        </div>
        
    </div>

%include('./footer.tpl')
