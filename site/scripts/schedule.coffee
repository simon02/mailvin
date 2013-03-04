$ ->

  $('#add_email_template').click ->
    template = $('#new_email_template > div').clone()
    numbers = ['first','second','third','fourth','fifth','sixth','seventh','eighth','nineth','tenth','eleventh','twelveth','thirteenth','fourteenth','fifteenth']
    emails = $('form .email').length
    if emails < numbers.length
      template.find('h4 .number').text(numbers[emails])
    else
      template.find('h4').text('This is turning into spam')
    template.insertAfter($('form .email').last())
    template.find('select').focus()
    false
