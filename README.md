## :wrench: アプリ名
「Minimum」

## :globe_with_meridians: URL
https://myminimum.herokuapp.com

## :key: 採用ご担当者様のアカウント
メールアドレス：「saiyou4444@gmail.com」<br>
パスワード：「saiyou4444」

## :scroll: アプリ概要
断捨離した物と購入した物を投稿することで、所持品の管理をすることができるアプリです。<br>
所持品（断捨離した物と購入した物両方）を把握することで、無駄な買い物を減らすことが目的となっています。<br>
<br>
検索機能やタグ機能もあるため、他のユーザーの投稿も確認しやすいようになっています。<br>
他のユーザーの投稿（断捨離の一例など）を見ることによって、自身の所持品に対する意識を改める機会にもなります。<br>
<br>
アプリ内では、無駄な物を所有しないこと・無駄な買い物をしないことを良しとするため、<br>
断捨離した物の投稿　→　「いいね」ボタン、　購入した物の投稿　→　「だめね」ボタン<br>
を押下できる仕様になっており、それぞれコメントもできるようになっています。<br>
<br>
このアプリを上手に活用すれば、アプリ名の通り「MINIMUM」な生き方ができるようになるでしょう！

## :thought_balloon: アプリ開発の背景（意図）
母親が買い物をする際に、自分にとって本当に必要な物かどうか迷う時が多々あるとのことでした。<br>
また、自分自身も無駄な物は所有しない「ミニマリスト」になることに理想を抱いていました。<br>
そんな母親の悩みを解決することと自分のニーズにマッチするようなアプリを作成しようと考えました。<br>

## :computer: デモ
<img src ="https://user-images.githubusercontent.com/58421780/80297214-24d8a280-87bc-11ea-8846-e77180dfe747.gif">


### :art: 使用技術
- 「Ruby on Rails」でアプリ製作
- 「Docker」で開発環境を構築
- 「Haml」「Scss」でコード記述
- 「devise」でユーザー機能を実装
- 「Ajax通信」でコメント機能を実装
- 「RuboCop」で静的コード解析テスト
- 「RSpec」で単体テストと統合テスト
- 「CircleCI」で自動テスト
- 「heroku」でデプロイ
- 「AWS（S3）」でストレージ管理

## :memo: 課題と今後実装したい機能
- 投稿された写真の色と文字の色が同系色の場合に見づらくなることを解決したい。
- ユーザーのフォロー機能を実装したい。
- CDツールで自動デプロイができるようにしたい。

## :triangular_ruler: DB設計
### users(devise)テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|encrypted_password|string|null: false|

### Association
- has_many :buys, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :hates, dependent: :destroy
- has_many :dumps, dependent: :destroy
- has_many :dump_comments, dependent: :destroy
- has_many :likes, dependent: :destroy

### dumpsテーブル
|Column|Type|Options|
|------|----|-------|
|goods|string|null: false|
|price|string|null: false|
|image|string||
|description|text|null: false|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user
- has_many :dump_tags, dependent: :destroy
- has_many :tags, through: :dump_tags
- has_many :dump_comments, dependent: :destroy
- has_many :likes, dependent: :destroy

### tagsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|unique: true|

### Association
- has_many :buy_tags, dependent: :destroy
- has_many :buys, through: :buy_tags
- has_many :dump_tags, dependent: :destroy
- has_many :dumps, through: :dump_tags

### dump_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|dump_id|references|foreign_key: true, index: true|
|tag_id|references|foreign_key: true, index: true|

### Association
- belongs_to :dump
- belongs_to :tag

### likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|dump_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :dump

### dump_commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|foreign_key: true, index: true|
|dump_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :dump

### buysテーブル
|Column|Type|Options|
|------|----|-------|
|goods|string|null: false|
|price|string|null: false|
|image|string||
|description|text|null: false|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user
- has_many :buy_tags, dependent: :destroy
- has_many :tags, through: :buy_tags
- has_many :comments, dependent: :destroy
- has_many :hates, dependent: :destroy

### buy_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|buy_id|references|foreign_key: true, index: true|
|tag_id|references|foreign_key: true, index: true|

### Association
- belongs_to :buy
- belongs_to :tag

### hatesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|buy_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :buy

### commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|foreign_key: true, index: true|
|buy_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :buy


## :octocat: 製作者
- [Qiita](https://qiita.com/Daiki-Abe)
