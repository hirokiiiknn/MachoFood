json.array! @tweets do |tweet|
  json.id tweet.id
  json.title tweet.title
  json.text tweet.text
  json.image tweet.image.url
  json.detail tweet.detail
  json.protein tweet.protein
  json.carb tweet.carb
  json.fat tweet.fat
  json.title tweet.title
  json.likes_count tweet.likes_count
  json.user_id tweet.user_id
  json.nickname tweet.user.nickname
  json.user_sign_in current_user
end