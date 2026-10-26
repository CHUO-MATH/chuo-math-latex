# LaTeX環境構築ガイド（Docker編）

最終更新日: 2026-10-26

## はじめに：なぜDocker（DevContainer）なのか？

この構築方法は、PCに直接LaTeXをインストールするのではなく、**Dockerコンテナ（仮想環境）** の中にLaTeX環境を閉じ込める手法です。

### メリット

1. **環境の統一:** MacでもWindowsでもLinuxでも、**完全に同じバージョンのTeX Live** が動作します。「先生のPCでは動くのに…」というトラブルがゼロになります。  
2. **汚染防止:** PC本体に数GBのソフトをインストールしません。不要になったらフォルダを削除するだけで環境が消えます。  
3. **復元性:** PCを買い替えても、設定ファイルをコピーするだけで5分後には執筆を再開できます。

## Step 1: 事前準備

以下の3つをインストールしてください。

1. **Docker Desktop**  
   * Mac: [公式サイト](https://www.docker.com/products/docker-desktop/)からダウンロード（Apple Silicon用を選択）。  
   * Windows: 同じく公式サイトから。**WSL2バックエンド** の使用を推奨します。  
2. **VS Code**  
3. **拡張機能「Dev Containers」**  
   * VS Codeの拡張機能マーケットプレイスで ms-vscode-remote.remote-containers を検索してインストール。

## Step 2: 設定ファイルの配置

Docker環境で執筆するための「魔法のフォルダ」を作ります。

1. 新しいプロジェクトフォルダを作成します（例: MyThesis）。  
2. その中に **.devcontainer** という名前のフォルダを作成します。  
3. .devcontainer フォルダの中に、以下の **devcontainer.json** を作成します。

### .devcontainer/devcontainer.json

このファイルが環境の設計図です。TeX Live 公式の `texlive/texlive` イメージ（全パッケージ入り）を使用します。日本語の処理系（uplatex など）や biber もすべて含まれているので、テンプレートがそのままコンパイルできます。

```jsonc
{
	"name": "LaTeX Dev Container",
	// TeX Live 公式イメージ（全パッケージ入り）を使用
	"image": "texlive/texlive:latest",
	  
	// コンテナ起動時にインストールするVS Code拡張機能
	"customizations": {
		"vscode": {
			"extensions": [
				"James-Yu.latex-workshop", // LaTeX Workshop
				"MS-CEINTL.vscode-language-pack-ja" // 日本語化
			],
			// コンテナ内でのVS Code設定（ローカルの設定より優先されます）
			"settings": {
				"latex-workshop.latex.autoBuild.run": "onSave",
				"latex-workshop.view.pdf.viewer": "tab",
				"latex-workshop.latex.recipes": [
					{
						"name": "uplatex",
						"tools": [
							"latexmk_uplatex"
						]
					}
				],
				"latex-workshop.latex.tools": [
					{
						"name": "latexmk_uplatex",
						"command": "latexmk",
						"args": [
							"-gg",
							"-pdfdvi",
							"%DOC%"
						]
					}
				]
			}
		}
	},

	// ファイル権限のトラブルを防ぐ設定
	"remoteUser": "root"
}
```

## Step 3: プロジェクトファイルの配置

プロジェクトフォルダの直下（.devcontainer の隣）に、いつものファイルを置きます。

1. **.latexmkrc**  
   * コンテナ内部で latexmk を動かすための設定です。  
   * **重要:** Docker環境ではホームディレクトリの設定を読み込むのが難しいため、**必ずプロジェクト直下に置いてください。**

```perl
#!/usr/bin/perl
$latex            = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex           = 'upbibtex %O %B';
$biber            = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$makeindex        = 'upmendex %O -o %D %S';
$dvipdf           = 'dvipdfmx %O -o %D %S';
```

2. **main.tex**  
   * 授業で配布されたテンプレートファイル。

## Step 4: 起動と執筆

ここが魔法の瞬間です。

1. VS Codeで **プロジェクトフォルダ（MyThesis）** を開きます。  
2. 画面右下に「Reopen in Container」という通知が出ます。クリックしてください。  
   * 出ない場合は、左下の青い \>\< アイコンをクリックし、**「Reopen in Container」** を選択します。  
3. **初回のみ**、約4〜5GBのイメージのダウンロードと構築が始まります（回線によって10〜30分程度かかります）。  
4. 起動が完了すると、左下の表示が **「Dev Container: ...」** に変わります。

これで、あなたのVS CodeはDockerの中に接続されました。  
あとは通常通り main.tex を保存すれば、コンテナ内で uplatex が走り、PDFが生成されます。

## FAQ / トラブルシューティング

### Q. 初回の起動がすごく遅い

A. 約4〜5GBあるTeX Liveイメージ全体をダウンロードしているためです。2回目以降は数秒で起動します。

### Q. Windowsで動作が重い

A. プロジェクトをWindows側（Cドライブ）に置いていませんか？ 劇的に高速化するために、**WSL2の領域**にファイルを置くことを強く推奨します。手順は巻末の **「Appendix: WindowsユーザーのためのWSL2活用ガイド」** をご覧ください。

### Q. コンテナを削除したい

A. Docker Desktopを開き、「Containers」タブから該当するコンテナをゴミ箱アイコンで削除してください。さらに容量を空けたい場合は「Images」から texlive/texlive を削除します。

### Q. 必要なパッケージがないと言われる

A. texlive/texlive は全パッケージ入りなので、通常は起きません。`File 'xxx.sty' not found` と出た場合は、まずパッケージ名のスペルミスを疑ってください。TeX Live に含まれていない独自のスタイルファイル（学会配布のものなど）は、`.tex` と同じフォルダに置けば読み込まれます。

## Appendix: WindowsユーザーのためのWSL2活用ガイド

WindowsでDockerを使う場合、プロジェクトファイルをどこに置くかでコンパイル速度が10倍以上変わることがあります。  
Windows標準のドキュメントフォルダ（C:\\Users\\...）ではなく、WSL2（Linux）の管理領域に置くのが鉄則です。

### なぜ速くなるのか？

DockerコンテナはLinuxで動いています。Windowsのファイルシステム（NTFS）へのアクセスは、変換処理が入るため非常に低速です。  
一方、WSL2の領域はLinuxネイティブのファイルシステムなので、コンテナから直接・高速に読み書きできます。

### 手順：WSL2領域への配置と開き方

1. **WSL2 (Ubuntu) の準備**  
   * PowerShellで wsl \--install を実行し、Ubuntuが入っている状態にします。  
2. **Linux領域を開く**  
   * エクスプローラーのアドレスバーに \\\\wsl$ と入力してEnterを押します。  
   * Ubuntu \-\> home \-\> (ユーザー名) と進みます。ここがあなたのLinux上のホームディレクトリです。  
3. **プロジェクトの配置**  
   * この場所に MyThesis などのプロジェクトフォルダを作成し、devcontainer.json や main.tex を配置します。  
4. **VS Codeで開く**  
   * VS Codeを起動し、左下の緑色のボタン（リモートインジケーター）をクリックします。  
   * **「Connect to WSL」** を選択し、Ubuntuに接続します。  
   * 「フォルダを開く」から、先ほど作ったフォルダ（例: /home/username/MyThesis）を選択します。  
   * この状態でさらに .devcontainer が検出されると、「Reopen in Container」の通知が出るのでクリックします。

これで、**「Windows上で、WSL2を経由して、Dockerコンテナ内のTeXを使う」** という最速の構成が完成します。