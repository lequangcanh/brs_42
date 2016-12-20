$(document).on('change','#book_image', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert('Maximum file size is 5MB. Please choose a smaller file.');
  }
});

$(document).on('click', 'input[type=radio]', function() {
  $('form').submit();
  alert('Thanks for rating');
});
