# AI Photo Story

[![Deploy to Cloudflare](https://deploy.workers.cloudflare.com/button)](https://deploy.workers.cloudflare.com/?url=https://github.com/abc123/ai-photo-story)

> 上のボタンは、`abc123` を自分の GitHub アカウント名に置き換えたリポジトリのURLで、使えます。

写真を1枚選ぶと、AI（Gemini）がタイトル・ストーリー・ハッシュタグをつけてくれる、ちいさな写真SNSです。タイムラインに並び、Discord のチャンネルにも投稿されます。

- 作り方（初心者向け・全手順）：[docs/how-to-build.md](docs/how-to-build.md)

AIが書くコメントは、実際の出来事と違ったり、的外れだったりします。そのズレも込みで楽しむためのアプリです。

## 特徴

- 写真を選ぶだけ。10〜20秒でストーリーができる
- キャラクターを3種から選べる（天然ツッコミ助手 / グルメ評論家 / 詩人）
- 写真の撮影日時と位置情報を読み取り、場所を踏まえたコメントにできる（保存・表示するのは町・市レベルの地名だけ。緯度経度は保存しません）
- 投稿は合言葉で守る。合言葉が未設定のときは、投稿できない
- Cloudflare Workers + D1 だけで動く（サーバー不要）

## かんたんセットアップ（ボタンを押すだけ）

1. 上の「Deploy to Cloudflare」ボタンを押す
2. Cloudflare と GitHub にログインして、画面の案内に進む
3. 入力欄が出たら、次の3つを入れる
   - `GEMINI_API_KEY`：Gemini の API キー
   - `PASSCODE`：投稿に必要な合言葉（好きな言葉）
   - `DISCORD_WEBHOOK_URL`：Discord の投稿先チャンネルのウェブフック URL（空でも動きます）
4. デプロイが終わったら、表示されたURLを開く

データベースとテーブルは、自動で作られます。

## 構成

- `public/index.html` : 画面（写真選択・設定・使い方・タイムライン）
- `src/worker.js` : Cloudflare Worker（Gemini 呼び出し・D1 保存・Discord 投稿）
- `schema.sql` : テーブル定義の控え（Worker が初回アクセスで自動作成します）
- `wrangler.jsonc` : Worker の設定（データベースは自動で作られます）
- `.dev.vars.example` : 必要な秘密情報の名前の一覧（値は入れないでください）

## 必要な設定（Cloudflare の Worker → 設定 → 変数とシークレット）

- `GEMINI_API_KEY`（シークレット）：Gemini の API キー
- `PASSCODE`（シークレット）：投稿に必要な合言葉
- `DISCORD_WEBHOOK_URL`（シークレット・省略可）：投稿先チャンネルのウェブフック URL
- `GEMINI_MODEL`（テキスト・省略可）：既定は `gemini-flash-latest`

秘密の情報は、コードや GitHub に絶対に書かないでください。詳しい手順は [作り方](docs/how-to-build.md) を見てください。
