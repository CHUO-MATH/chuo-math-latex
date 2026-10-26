# 数理系学生のためのLaTeX環境構築ガイド

最終更新日: 2026-10-26

## はじめに：なぜ環境構築が必要か？

数学や物理のレポート、そして卒業論文では **LaTeX（ラテフ）** という組版システムを使うことが世界標準です。Wordとは異なり、「コマンドで論理構造を書くと、自動で美しい文書が生成される」のが特徴です。

本ガイドでは、以下の構成を数理系の標準として採用します。

* **エンジン:** uplatex (伝統的な資産と現代のUnicode対応の両立)  
* **クラス:** jlreq (最新のJIS組版規格準拠)  
* **自動化:** latexmk (保存するだけでPDFを更新)  
* **エディタ:** 最近の標準はTeX専用エディタ（Mac: TeXShop / Windows: TeXworks）かVS Code系エディタです。好きな方を選んでください。

## 第1部：Macユーザー向け

MacはUNIXベースであり、LaTeX環境との親和性が非常に高いです。**Homebrew** という管理ツールを使ってインストールします。

### Step 0: ターミナルの準備とHomebrewのインストール

**Homebrew (ホームブリュー)** とは、Macにソフトウェアを簡単にインストール・管理するためのツールです。これがないと始まりません。

1. **ターミナルを開く**  
   * Command \+ Space を押し、スポットライト検索で「terminal」と入力してEnter。  
   * 黒（または白）い画面が出てきます。ここに入力していきます。  
2. **Homebrewのインストール**  
   * 以下のコマンドをコピーし、ターミナルに貼り付けて Enter を押してください。  
   * （途中でパスワードを求められたら、Macのログインパスワードを入力します。入力中、**文字は画面に表示されませんが**、気にせず入力してEnterを押してください）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. **【重要】パスを通す (Path Setup)**  
   * インストール完了時に、画面の下の方に **Run these two commands in your terminal to add Homebrew to your PATH:** という表示が出ているはずです。  
   * そこに書かれている2行のコマンドを**必ず**実行してください。  
   * *（もし見逃した場合は、以下のコマンドを順に実行してください）*

```bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

4. **確認**  
   * 以下のコマンドを入力してバージョン番号が出れば成功です。

```bash
brew --version
```

### Step 1: MacTeXのインストール

Homebrewを使って、LaTeXの「全部入りパック」である **MacTeX** をインストールします。容量が5GB以上あるため、安定したWi-Fi環境で行ってください。

1. ターミナルで以下を実行します。

```bash
brew install --cask mactex
```

* ※ cask は「GUIアプリも含めてインストールする」という意味です。  
* ※ 完了まで数十分かかることがあります。気長に待ちましょう。  
2. 完了後、ターミナルを一度再起動し、以下を入力してバージョンが出れば成功です。

```bash
tex -version
```

* ※ このとき、GUIエディタ **TeXShop** も `/Applications/TeX/TeXShop.app` に自動でインストールされます。TeXShopを使いたい人は、第4部の「TeXShopを使う場合」を参照してください。
* ※ **Ghostscriptについて:** MacTeXの公式インストーラを直接使う方法だと、インストーラ内蔵のGhostscriptとHomebrewのGhostscriptが衝突することがあり、「カスタマイズ」画面で内蔵Ghostscriptを外す対処が必要になる場合があります。本ガイドの `brew install --cask mactex` 方式では、GhostscriptはHomebrewの依存パッケージとして別途インストールされる仕組みになっており、この衝突は起きません。特に何もする必要はありません。

### Step 2: パッケージのアップデート (重要)

インストール直後の環境は少し古い可能性があるため、最新の状態に更新します。これをやらないと、「教科書通りのコードが動かない」原因になります。

1. ターミナルで以下を実行します。

```bash
sudo tlmgr update --self --all
```

* **注意:** sudo コマンドを使うため、Macのログインパスワードを求められます。パスワード入力中は画面に何も表示されませんが、入力してEnterを押してください。  
* ※ tlmgr (TeX Live Manager) が、システム全体 (--self) と全パッケージ (--all) を最新版に更新します。

## 第2部：Windowsユーザー向け

Windowsの場合は、公式インストーラを使用します。

### Step 1: TeX Liveのインストール

1. **インストーラのダウンロード**  
   * [TeX Live 公式サイト (tug.org)](https://www.tug.org/texlive/) にアクセスします。  
   * download \-\> install-tl-windows.exe をクリックしてダウンロードします。  
2. **インストール実行**  
   * ダウンロードした install-tl-windows.exe を実行します。  
   * 「Install」を選択し、基本的には「次へ」を押していけばOKです。  
   * **注意:** インストールにはネットワーク経由で数千個のファイルをダウンロードするため、**1〜3時間かかる**ことがあります。PCがスリープしないように設定して放置してください。  
3. **確認**  
   * インストール完了後、コマンドプロンプト（またはPowerShell）を開き、以下を実行して確認します。

```cmd
tex -version
```

### Step 2: パッケージのアップデート (重要)

Windowsの場合も、念のため最新の状態に更新しておきます。

1. コマンドプロンプト（またはPowerShell）を**管理者権限で**開きます（アイコンを右クリックして「管理者として実行」）。  
2. 以下のコマンドを実行します。

```cmd
tlmgr update --self --all
```

* ※ エディタの設定は第4部にまとめています。Windows標準の **TeXworks** の設定は第4部 Step 2 を参照してください。

## 第3部：Docker環境について

「Windowsだと動作が重い」「Macのシステムを汚したくない」「将来PCを買い替えても即座に環境を再現したい」という人向けの構成です。詳細は[Docker編](docker.md)を参照してください。

## 第4部：エディタの設定 (共通)

ここからはMac/Windows共通です。エディタを設定し、快適な執筆環境を作ります。標準のエディタは **1. TeXShop（Mac）、2. TeXworks（Windows）** で、どちらもOSにTeXをインストールすると自動で付属します。慣れている人や、AI補完などを使いたい人は **3. VS Code系エディタ** も選べます。どれを使うかは好みで決めて構いません。

* **TeXShopを使う場合（Macのみ）** → Step 1へ  
* **TeXworksを使う場合（Windowsのみ）** → Step 2へ  
* **VS Code系エディタを使う場合** → Step 3へ

### Step 1: TeXShopを使う場合（Macのみ）

MacTeXに標準で付属する**TeXShop**です（追加インストール不要）。TeXShopには uplatex 用の設定が「プロファイル」としてあらかじめ用意されているので、選ぶだけで使えます。

1. TeXShopを起動し、メニューの **「TeXShop」→「環境設定」** を開きます。
2. 「Engine」タブを開き、左下の **「設定プロファイル（Default profiles）」** から、以下のどちらかを選び、右下の **「OK」** を押します。
3. 環境設定をいったん閉じて、TeXShopを再起動します。
4. main.tex を開き、Cmd+T（タイプセット）を実行します。

どちらのプロファイルを選ぶかは好みで構いません。

* **「upTeX (latexmk)」**
  * latexmk 経由で uplatex → dvipdfmx という、本ガイドの標準構成と同じ流れでコンパイルします。
  * 相互参照や目次が必要な回数だけ自動的に再コンパイルしてくれるので、基本的にタイプセットを1回押すだけで済みます。
  * 参考文献（BibTeX）もこのプロファイルで処理できます。
  * ※ 索引コマンドが `upmendex` ではなく `mendex` になっている、`biber`（BibLaTeX）には対応していないなど、Step 3-3の `.latexmkrc` と完全に同じではありません。普通のレポートなら気にしなくて大丈夫です。
* **「upTeX (ptex2pdf)」**
  * `ptex2pdf` というコマンドで uplatex を1回実行し、dvipdfmxでPDF化するだけのシンプルな仕組みです（latexmkは使いません）。
  * 相互参照や目次が反映されるまでに複数回の再実行が必要になった場合、Cmd+Tを**自分で数回押す**必要があります（自動再実行はされません）。
  * 索引・参考文献（mendex・bibtex・biber）には対応していません。

参考文献（BibTeX）を使うなら「upTeX (latexmk)」を選んでください。索引や BibLaTeX を使う本格的なレポートでは、Step 3のVS Code系エディタを使ってください。

### Step 2: TeXworksを使う場合（Windowsのみ）

TeX Liveに標準で付属する**TeXworks**です（追加インストール不要）。

1. スタートメニューで「TeX Live YYYY」フォルダから **「TeXworks editor」** を探して起動します（検索ボックスに `texworks` と打ち込んでも起動できます）。
2. メニューの **「編集」→「設定」** を開きます。
3. 「タイプセット」タブを開き、「デフォルト」を **「upLaTeX (ptex2pdf)」** にします（本ガイドの標準構成である uplatex に対応するのはこれです）。
4. **もし候補に「upLaTeX (ptex2pdf)」が無ければ**、管理者権限のコマンドプロンプト（またはPowerShell）で以下を実行してから、もう一度設定を開いてください。

```cmd
tlmgr postaction install script ptex2pdf
```

5. 設定後、いったんTeXworksを閉じて開き直すと反映されます。

#### 【補足】タイプセット方法を手動で作る場合

`tlmgr postaction install script ptex2pdf` を実行しても候補に出てこない場合や、設定内容を自分で確認・調整したい場合は、以下の手順で手動登録できます。

1. 「編集」→「設定」→「タイプセット」タブを開きます。
2. 「タイプセットの方法」の一覧の下にある **[+]** ボタンを押します。
3. 「タイプセットの方法を設定する」ダイアログで、以下のように入力します。
   * **名前:** `upLaTeX (ptex2pdf)`
   * **プログラム:** `ptex2pdf.exe`
   * **引数:** 下の **[+]** ボタンで1つずつ追加します（**順番が重要**です）。
     1. `-l` （数字の1ではなく小文字のエル。LaTeXとして処理する指定）
     2. `-u` （upLaTeXを使う指定。これがないとpLaTeXで処理され、テンプレートがエラーになります）
     3. `-ot`
     4. `$synctexoption`
     5. `$fullname`
   * **「実行後、PDFを表示する」にチェック**を入れます。
4. **[OK]** を押して保存します。
5. 「タイプセットの方法」一覧に追加された「upLaTeX (ptex2pdf)」を選び、「デフォルト」に設定して **[OK]** を押します。

* ※ 複数バージョンのTeXworksが検索結果に出て紛らわしい場合は、右クリックして「ファイルの場所を開く」で場所を確認し、新しい方（`C:\texlive\YYYY\bin\windows` にあるもの）を使ってください。日本語向けの細かい調整が入っているため、こちらが推奨です。
* ※ 以前に作成した .tex ファイルを開いて文字化けする場合は、TeXworksの標準の文字コードがUTF-8なのに対し、ファイルがShift_JISなどになっていることが原因です。右下の文字コード表示をクリックして一度「Shift_JIS」を選び、もう一度クリックして「選択した文字コードで再読み込みする」を選んでください。最終的にはUTF-8に統一することをおすすめします。
* ※ TeXworksはptex2pdf方式のみで、latexmkによる自動再コンパイルはありません。索引・参考文献を使う本格的なレポートでは、Step 3のVS Code系エディタを使ってください。

### Step 3: VS Code系エディタを使う場合

LaTeX Workshop拡張機能を使った構成です。以下のようなVS Code系エディタが対象です。

* **VS Code**  
* **Cursor** (AI活用)

* ※ Zed・Neovimなど上記以外のエディタでも、LaTeX Workshop相当の拡張機能や設定が使える環境であれば同様にコンパイルできるはずですが、各自での設定が必要になるため本ガイドの対象外とします。

#### Step 3-1: エディタと拡張機能のインストール

エディタをインストール後、拡張機能マーケットプレイスで **「LaTeX Workshop」** を検索し、インストールします。

#### Step 3-2: 設定ファイル (settings.json) の編集

これが最強の環境を作るための**秘伝のタレ**です。これを設定することで、保存時の自動コンパイルなどが有効になります。

1. エディタでコマンドパレットを開きます。  
   * Mac: Cmd \+ Shift \+ P  
   * Win: Ctrl \+ Shift \+ P  
2. 入力欄に Preferences: Open User Settings (JSON) と入力して選択します。  
3. 開いたファイルの中身（波括弧 { } の中）に、以下のコードを**コピペ**してください。

```jsonc
{
    /* --- LaTeX Workshop 設定 (数理系標準) --- */
    
    // 1. レシピ設定 (uplatexを標準、lualatexをサブに)
    // ※一番上に書かれたレシピが標準で利用されます
    "latex-workshop.latex.recipes": [
        {
            "name": "uplatex (Standard)",
            "tools": ["latexmk_uplatex"]
        },
        {
            "name": "lualatex (Modern)",
            "tools": ["latexmk_lualatex"]
        }
    ],

    // 2. 具体的なコマンド定義 (詳細は .latexmkrc に任せる)
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk_uplatex",
            "command": "latexmk",
            "args": ["-gg", "-pdfdvi", "%DOC%"]
        },
        {
            "name": "latexmk_lualatex",
            "command": "latexmk",
            "args": ["-gg", "-pdflua", "%DOC%"]
        }
    ],

    // 3. 快適化設定
    "latex-workshop.latex.autoBuild.run": "onSave", // 保存時に自動ビルド
    "latex-workshop.view.pdf.viewer": "tab",        // エディタ内でPDF表示
    "latex-workshop.latex.autoClean.run": "onBuilt", // ビルドのたびに中間ファイルを掃除

    // 4. 生成物をエディタ画面から除外する設定
    "files.exclude": {
        "**/*.aux": true,
        "**/*.log": true,
        "**/*.fdb_latexmk": true,
        "**/*.synctex.gz": true
    }
}
```

#### Step 3-3: グローバルなコンパイル設定 (.latexmkrc)

コンパイルのルールを記述した .latexmkrc ファイルを**ホームディレクトリ**（Home直下）に配置します。これにより、すべてのプロジェクトで共通の設定が適用され、毎回ファイルをコピーする手間がなくなります。

1. エディタで「新規ファイル」を作成します。  
2. 以下の内容をコピペします。  
```perl
#!/usr/bin/perl
$latex            = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$lualatex         = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$xelatex          = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex           = 'upbibtex %O %B';
$biber            = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex        = 'upmendex %O -o %D %S';
$dvipdf           = 'dvipdfmx %O -o %D %S';
```

3. ファイルを**ホームディレクトリ**に保存します。ファイル名は必ず **.latexmkrc** （先頭にドットが必要）にしてください。  
   * **Macの場合:** /Users/(ユーザー名)/.latexmkrc  
     * (Finderで保存する場合は Cmd+Shift+. で隠しファイルを表示させる必要があるかもしれません)  
   * **Windowsの場合:** C:\\Users\\(ユーザー名)\\.latexmkrc

#### 【参考】設定ファイルの読み込み優先順位

latexmk は以下の順序で設定ファイルを読み込みます。

1. **プロジェクトフォルダ直下** (カレントディレクトリ)  
2. **Home直下** (グローバル設定)

基本的にはHome直下の設定が使われますが、特定のプロジェクトだけ設定を変えたい場合は、そのフォルダの中に別の .latexmkrc を置くことで設定を**上書き**できます。

## 第5部：レポートの書き始め方

環境構築お疲れ様でした。実際にレポートを書く際は、以下のルールを守ってください。

### 1. フォルダを作る

必ず「レポートごと」に新しいフォルダを作成してください。デスクトップやドキュメント直下にファイルを散らかしてはいけません。

### 2. 必須ファイルを置く

そのフォルダの中に、本リポジトリの [templates](../templates/) にあるテンプレートファイルをコピーして置きます。

* **main.tex** (テンプレート)：ここから書き始めます。  
* **references.bib** (参考文献データ)：必要に応じて置いてください。文献を `\cite` で引用したら、main.tex の最後にある参考文献の2行（`\bibliographystyle` と `\bibliography`）の先頭の `%` を外してください。

※ .latexmkrc はホームディレクトリにあるため、ここにコピーする必要はありません（特殊な設定をする場合を除く）。

### 3. 書く！

使っているエディタで main.tex を編集して保存（VS Code系なら Cmd+S / Ctrl+S、TeXShopなら Cmd+T でタイプセット）してください。  
プレビュー画面に美しい数式が表示されれば成功です！

## トラブルシューティング

* **Q. latexmk コマンドが見つからないと言われる**  
  * A. (Mac) ターミナルを再起動しましたか？ パス設定（Step 0-3）を行いましたか？  
  * A. (Win) インストール後に再起動が必要な場合があります。  
* **Q. コンパイルがいつまでも終わらない**  
  * A. ログファイル (.log) を見て、最後に ? で止まっていませんか？ エラーで対話モードになっています。ターミナルなら x を押して終了し、エラー箇所（スペルミスなど）を直してください。  
* **Q. プレビューが表示されない**  
  * A. 右上の虫眼鏡アイコンなどが並んでいる場所にある「View PDF」ボタンを押してみてください。

---

**※ 本ガイドは必要最低限の手順だけをまとめた簡易版です。** より標準的・網羅的なインストール方法や、エラーが出たときの詳しい対処法を知りたい場合は、奥村晴彦『LaTeX2e美文書作成入門』（技術評論社）の最新版を購入して読んでください。TeX Live / MacTeX / TeXShop / TeXworks の公式に近い設定方法が、本書よりずっと詳しく解説されています。
