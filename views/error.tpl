
%include('./header.tpl')

    <div id="contents" class="pure-u-1">
        <div class="pure-u-1">
            <h2 class="headline"><span class="marked-font">Error: エラーが発生しました！</span></h2>
            <br>
            <h2>エラー内容：{{ message }}</h2>
            <h2>エラーがなくならない場合はCache・Cookieの削除を行ってください。</h2>
        </div><br />

        <div class="pure-u-1">
            <img src="./static/img/error.png" class="pure-img center">
        </div>
        
        <div class="pure-u-1 center">
            <a href="/signup"><button class="pure-button pure-button">ユーザー登録画面に戻る</button></a>
            <a href="/login"><button class="pure-button pure-button">ログイン画面に戻る</button></a>
        </div>

    </div><!-- contents -->

%include('./footer.tpl')
