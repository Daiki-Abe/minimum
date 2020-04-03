$(function(){
  $('buy-comment__send-form').on('submit', function(e){
    e.preventDefault();
    var formData = new formData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
  })
})