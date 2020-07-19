%include('./header.tpl')
    <div class="pure-u-1-3"></div>
    <div id="contents" class="pure-u-1-3">
        <div class="pure-u-1">
            <h2>こんにちは，<span id="hello-user">{{username}}</span>さん</h2><br>
            <h2>ここは，<span class="marked-font">みんなの掲示板</span>用のページです．</h2>
        </div>
        <ol id="comment-list" style="margin:2em;">
        %if xss_security == True:
            %for comment in comments:
                <li style="margin:2em; line-height:150%; border: solid 1px #ccc;">{{comment.user.username}}： {{comment.datetime}}<br />
                {{comment.comment}}</li>
            %end
        %else:
            %for comment in comments:
                <li style="margin:2em; line-height:150%; border: solid 1px #ccc;">{{comment.user.username}}： {{comment.datetime}}<br />
                {{!comment.comment}}</li><!-- disable escape for a purpose of cyberattack -->
            %end
        %end
        </ol>
		<form action="/bbs" method="post" class="form pure-form pure-form-stacked">
            <div class="pure-g">
                <div class="pure-u-1">
                    <input type="hidden" name="token" value="a73+f*&t5" />
                </div>
                <div class="pure-u-1">
                    <textarea name="comment" rows="5" cols="70" placeholder="何か書いてください"></textarea>
                </div>
                <div class="pure-u-1">
                    <button type="submit" class="pure-button pure-button-primary center">書き込む</button>
                </div>
			</div>
		</form>
        <div class="pure-u-1 center">
            <a href="/mypage"><button class="pure-button pure-button">マイページに戻る</button></a>
            <a href="/login"><button class="pure-button pure-button">ログイン画面に戻る</button></a>
            <a href="/logout"><button class="pure-button pure-button">ログアウトする</button></a>
            <a href="/initdb"><button class="pure-button pure-button">データベースの初期化</button></a>
        </div>
    </div>
    <div class="pure-u-1-3"></div>
%include('./footer.tpl')
