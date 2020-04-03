$(function(){
  function buildHTML(comment){
    var html = `<div class = buy-comment__list>
                  <div class = buy-comment__list-writter>
                    ${comment.user_name}:
                  </div>
                  <div class = buy-comment__list-comment>
                    ${comment.text}
                  </div>
                </div>`
    return html;
  }
  $('#buy-comment__send-form').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.ajax').append(html);
      $('.buy-comment__send-text').val('');
      $('.buy-comment__send-submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
});