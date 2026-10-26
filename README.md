# chuo-math-latex

数理系の学生・大学院生向けの、LaTeX 環境構築ガイドとテンプレート集です。

標準の構成は **upLaTeX ＋ jlreq ＋ latexmk** です。エディタは VS Code（LaTeX Workshop）のほか、TeXShop（Mac）と TeXworks（Windows）にも対応しています。

## どれを読むか

| 文書 | 対象 | 内容 |
| --- | --- | --- |
| [クイックスタート](docs/quickstart.md) | まず動かしたい人（Mac・Windows） | インストールからレポートを書き始めるまでの最短手順 |
| [完全ガイド Mac編](docs/mac.md) | Mac で腰を据えて使う人 | MacTeX の導入、VS Code の設定、エンジンの仕組み、組版のルール、参考文献・分割管理・Beamer |
| [完全ガイド Windows編](docs/windows.md) | Windows の人 | Windows の注意点、クラウド・TeXworks・Docker の3つの選択肢、WSL2 の準備 |
| [Docker編](docs/docker.md) | Docker で環境を作りたい人（Mac・Windows 共通） | Dev Container で TeX Live を動かす手順とトラブルシューティング |

迷ったら、まずクイックスタートで動かし、困ったときや仕組みを知りたくなったときに完全ガイドを読んでください。理論・ルール・応用（第5〜7章）は Mac編にまとめてあり、Windows の人も同じものを読みます。

## ファイル

| 場所 | 内容 |
| --- | --- |
| [templates/](templates/) | テンプレート一式 |
| `templates/main.tex` | 書き始め用のレポートテンプレート |
| `templates/sample.tex` | 数式・定理・参考文献の書き方の見本 |
| `templates/template-beamer.tex` | 発表スライド（Beamer）のテンプレート |
| `templates/references.bib` | 参考文献データの例（BibTeX） |
| `templates/.latexmkrc` | latexmk の設定。ホームディレクトリ（またはプロジェクト直下）に置く |
| [docker_sample/](docker_sample/) | Docker 用のプロジェクトフォルダの見本。フォルダごとコピーして使う |
| [settings/vscode_settings.json](settings/vscode_settings.json) | VS Code の `settings.json` に追記する LaTeX Workshop の設定（クイックスタートと同じもの） |

## 動作環境

- TeX Live 2026（MacTeX 2026）。Docker編では `texlive/texlive:latest` を使います
- Linux 向けの手順は用意していません。Linux でも Docker編の手順はそのまま使えます

各文書の2行目に最終更新日を書いています。LaTeX の環境は毎年変わるので、古い日付の文書は最新情報と照らし合わせて読んでください。
