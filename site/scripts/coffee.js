(function() {

  $(function() {
    return $('a[rel="contextio"]').click(function() {
      return $.post('https://api.context.io/2.0/connect_tokens', {
        'callback_url': 'http://localhost:5000/mailbox/contextio_callback'
      }, function(data) {
        return console.log(data);
      });
    });
  });

}).call(this);

(function() {

  $(function() {
    return $('#add_email_template').click(function() {
      var emails, numbers, template;
      template = $('#new_email_template > div').clone();
      numbers = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'nineth', 'tenth', 'eleventh', 'twelveth', 'thirteenth', 'fourteenth', 'fifteenth'];
      emails = $('form .email').length;
      if (emails < numbers.length) {
        template.find('h4 .number').text(numbers[emails]);
      } else {
        template.find('h4').text('This is turning into spam');
      }
      template.insertAfter($('form .email').last());
      template.find('select').focus();
      return false;
    });
  });

}).call(this);
