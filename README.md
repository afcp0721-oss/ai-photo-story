# AI Photo Story


写真を1枚選ぶと、AI（Gemini）がタイトル・ストーリー・ハッシュタグをつけてくれる、ちいさな写真SNSです。タイムラインに並び、Discord のチャンネルにも投稿されます。

- 作り方（初心者向け・全手順）：[docs/how-to-build.md](docs/how-to-build.md)

AIが書くコメントは、実際の出来事と違ったり、的外れだったりします。そのズレも込みで楽しむためのアプリです。

## 特徴

- 写真を選ぶだけ。10〜20秒でストーリーができる
- キャラクターを3種から選べる（天然ツッコミ助手 / グルメ評論家 / 詩人）
- 写真の撮影日時と位置情報を読み取り、場所を踏まえたコメントにできる（保存・表示するのは町・市レベルの地名だけ。緯度経度は保存しません）
- 投稿は合言葉で守る。合言葉が未設定のときは、投稿できない
- Cloudflare Workers + D1 だけで動く（サーバー不要）

## このアプリの考え方

みんなで1つのサービスを使うのではなく、**自分用のものを、自分で作って動かす**アプリです。

- AI は、自分の Gemini の API キーで動きます（利用料は、自分の分だけです）。
- 投稿は、自分の Discord チャンネルに届きます。
- データは、自分の Cloudflare のデータベースに保存されます。

作った人同士が、投稿を見せ合ったり、相談したりできる場所（Discord など）があると、もっと楽しくなります。

## 作り方

[docs/how-to-build.md](docs/how-to-build.md) に、初心者向けの全手順があります。大まかな流れは次のとおりです。

1. Discord のウェブフックと、Gemini の API キーを用意する
2. Cloudflare で D1 データベースを作り、そのIDを `wrangler.jsonc` に書く
3. GitHub に上げて、Cloudflare の Worker として公開する
4. Worker に、3つの秘密情報（Secrets）を入れる

テーブルは、Worker が初回アクセスで自動で作ります。

## 構成

- `public/index.html` : 画面（写真選択・設定・使い方・タイムライン）
- `src/worker.js` : Cloudflare Worker（Gemini 呼び出し・D1 保存・Discord 投稿）
- `schema.sql` : テーブル定義の控え（Worker が初回アクセスで自動作成します）
- `wrangler.jsonc` : Worker の設定（`database_id` は、自分の D1 のIDに書き換えます）
- `.dev.vars.example` : 必要な秘密情報の名前の一覧（値は入れないでください）

## 必要な設定（Cloudflare の Worker → 設定 → 変数とシークレット）

- `GEMINI_API_KEY`（シークレット）：Gemini の API キー
- `PASSCODE`（シークレット）：投稿に必要な合言葉
- `DISCORD_WEBHOOK_URL`（シークレット・省略可）：投稿先チャンネルのウェブフック URL
- `GEMINI_MODEL`（テキスト・省略可）：既定は `gemini-flash-latest`

秘密の情報は、コードや GitHub に絶対に書かないでください。詳しい手順は [作り方](docs/how-to-build.md) を見てください。

## ライセンス

[MIT License](LICENSE)（Copyright (c) 2026 Jiico）。自由に使ったり、改造したり、配ったりできます。著作権の表示とライセンス文を残してください。
