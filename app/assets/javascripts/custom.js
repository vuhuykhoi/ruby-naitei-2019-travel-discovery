$(function() {
  return $('#what').autocomplete({
    source: $('#what').data('autocomplete-source')
  });
});

$(function() {
  return $('#address').autocomplete({
    source: $('#address').data('autocomplete-source')
  });
});

$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});

