$(function(){
  function buildHTML(comment){
    let html = `<div class="comments__c">
                  <a href="/users/${comment.user_id}">${comment.user_name}</a>
                    ${comment.text}
                </div>`
    return html;
  }
  $('.comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.comments').append(html);
      $('#comment_text').val('');
      $('.form__submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})



