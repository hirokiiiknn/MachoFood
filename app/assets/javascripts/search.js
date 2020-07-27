$(function() {
  let search_list = $(".contents.row");
  function appendTweet(tweet){
    if (tweet.user_sign_in && tweet.user_sign_in.id == tweet.user_id){
      let html = ` <a data-method="get" href="/tweets/${tweet.id}">
                    <div class="content_post" style="background-image: url(${tweet.image});">
                      <p>${tweet.text}</p>
                      <p2>${tweet.title}</p2>
                      <p3>${tweet.nickname}</p3>
                    </div>
                  </a> `
      search_list.append(html);
    } else{
      let html = `<a data-method="get" href="/tweets/${tweet.id}">
                    <div class="content_post" style="background-image: url(${tweet.image});">
                      <p>${tweet.text}</p>
                      <p2>${tweet.title}</p2>
                      <p3>${tweet.nickname}</p3>
                    </div>
                  </a>`
      search_list.append(html);
    }
  }

  function appendErrMsgToHTML(msg){
    let html = `<div class='name'>${msg}</div>`
    search_list.append(html);
  }


  $(".search-input").on("keyup", function() {
    let input = $(".search-input").val();
    $.ajax({
      type: 'GET',
      url: '/tweets/search',
      data: {keyword: input},
      dataType: 'json'
    })
    .done(function(tweets){
      search_list.empty();
      if (tweets.length !== 0) {
        tweets.forEach(function(tweet){
          appendTweet(tweet);
        });
      }
      else {
        appendErrMsgToHTML("一致するツイートがありません");
      }
    })
    .fail(function(){
      alert('error');
    });
  });
});