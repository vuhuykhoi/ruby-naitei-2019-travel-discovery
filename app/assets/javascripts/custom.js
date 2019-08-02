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
