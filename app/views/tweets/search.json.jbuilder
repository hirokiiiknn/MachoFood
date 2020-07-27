json.array! @tweets do |tweet|
  json.id tweet.id
  json.text tweet.text
  json.title tweet.title
  json.image tweet.image
  json.user_id tweet.user_id
  json.nickname tweet.user.nickname
  json.user_sign_in current_user
end