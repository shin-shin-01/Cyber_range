%include('./header.tpl')
    <div class="pure-u-1-3"></div>
    <div id="contents" class="pure-u-1-3">
        <div class="pure-u-1">
            <h2>ここは，<span class="marked-font">商品一覧</span>用のページです．</h2>
        </div>

        <div style="margin:2em; line-height:150%; border: solid 1px #ccc;">
             <h2><span class="marked-font">{{ select_category }}</span>の商品一覧</h2>
            %for result in results:
                <div style="text-align: left; margin-left: 2em"><img src="./static/img/shopping/{{ select_category }}/{{result}}.png" class="pure-img" style="width: 20%">{{ result }}</div>
            %end
        </div>

        <form action="/os" method="get" class="form pure-form pure-form-stacked">
            <fieldset>
                <legend>カテゴリー選択</legend>
                <select id="stacked-state" name="category">
                    %for cate in categories:
                        %if cate != ".DS_Store":
                            <option>{{ cate }}</option>
                        %end
                    %end
                </select>
                <div class="pure-u-1">
                    <button type="submit" class="pure-button pure-button-primary center">書き込む</button>
                </div>
            </fieldset>

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
