# Macho-Food

"Macho-Food" is an application where people who love working out or would love to be healthy, share their foods they make.

# DEMO

You can learn how to use it.
https://macho-food.herokuapp.com/
![](https://gyazo.com/2ed03513661346009a1779f22fa31935)

# Features

Tweet, Like and Comment, Follow, Unfollow etc...

# Requirement

* Ruby 2.6.5

# Installation

```zsh
rails _6.0.0_ new macho-food -d postgresql
```

# Usage

You can browse a lot of healthy foods and any foods which are suitable for building muscles. You can also make them by reading their article easily and quickly. Also upload any foods that you want to share to the world

# DB
  
## userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|introduce|string|null: false|
|image|string|null: false|
|profile|string|null: false|
|email|string|null: false, unique: true, index:true|
|password|string|null: false|


### Association
- has_many: likes, dependent: :destroy
- has_many: like_tweets, through: :likes, source: :tweet
- has_many: tweets
- has_many: comments
- has_many: active_relationships, class_name: "Relationship", foreign_key: :following_id
- has_many: followings, through: :active_relationships, source: :follower
- has_many: passive_relationships, class_name: "Relationship", foreign_key: :follower_id
- has_many: followers, through: :passive_relationships, source: :following
- mount_uploader: image, ImageUploader


## tweetsテーブル

|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|title|string|null: false|
|image|string|null: false|
|user_id|integer|null: false|
|likes_count|integer|null: false|
|fat|integer|null: false|
|carb|integer|null: false|
|protein|integer|null: false|
|detail|string|null: false|

### Association
- belongs_to: user
- has_many: comments
- has_many: likes, dependent: :destroy
- validates: protein, :carb, :fat, :image, :title, presence: true
- mount_uploader: image, ImageUploader

## relationshipsテーブル

|Column|Type|Options|
|------|----|-------|
|following_id|references|null:false, foreign_key: true|
|follower_id|references|null:false, foreign_key: true|

### Association
- belongs_to: following, class_name: "User"
- belongs_to: follower, class_name: "User"

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|tweet_id|references|null:false, foreign_key: true|
|user_id|references|null:false, foreign_key: true|


### Association
- belongs_to: tweet, counter_cache: :likes_count
- belongs_to: user
- validates: tweet_id, uniqueness: { scope: :user_id }


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|tweet_id|references|null:false, foreign_key: true|
|user_id|references|null:false, foreign_key: true|
|text|text|null: false|



### Association
- belongs_to: tweet
- belongs_to: user
- validates: text, presence: true



# Author

* HirokiKato

Thank you!
