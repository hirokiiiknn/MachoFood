$(function() {
  let search_list = $(".contents.row");
  function appendTweet(tweet){
    if (tweet.user_sign_in && tweet.user_sign_in.id == tweet.user_id){
      let html = `
                  <div class="content_post" style="background-image: url(${tweet.image});">
                    <a data-method="get" href="/tweets/${tweet.id}">
                      <div class="pfc">
                        <p1>C :</p1>
                        <pf>F :</pf>
                        <pc>P :</pc>
                        <p>${tweet.carb}</p>
                        <pp>${tweet.fat}</pp>
                        <ppp>${tweet.protein}</ppp>
                      </div>
                      <p2>${tweet.title}</p2>
                      <p3>${tweet.nickname}</p3>
                    </a>
                    <div class="like-link" id="like-link-${tweet.id}">
                      <a data-method="get" href="/tweets/${tweet.id}"></a>
                      <a data-remote="true" rel="nofollow" data-method="delete" href="/like/${tweet.id}">
                        <div class="iine__button">
                          ❤️1
                        </div>
                      </a>
                    </div>
                  </div>
                  
                  `
      search_list.append(html);
    } else {
      let html = `
                  <div class="content_post" style="background-image: url(${tweet.image});">
                    <a data-method="get" href="/tweets/${tweet.id}">
                      <div class="pfc">
                        <p1>C :</p1>
                        <pf>F :</pf>
                        <pc>P :</pc>
                        <p>${tweet.carb}</p>
                        <pp>${tweet.fat}</pp>
                        <ppp>${tweet.protein}</ppp>
                      </div>
                      <p2>${tweet.title}</p2>
                      <p3>${tweet.nickname}</p3>
                    </a>
                    <div class="like-link" id="like-link-${tweet.id}">
                      <a data-method="get" href="/tweets/${tweet.id}"></a>
                      <a data-remote="true" rel="nofollow" data-method="delete" href="/like/${tweet.id}">
                        <div class="iine__button">
                          ❤️1
                        </div>
                      </a>
                    </div>
                  </div>
                  
                  `
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
      console.log(tweets)
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