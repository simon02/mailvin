$ ->

  $('a[rel="contextio"]').click ->
    $.post 'https://api.context.io/2.0/connect_tokens',
      'callback_url': 'http://localhost:5000/mailbox/contextio_callback'
    , (data) ->
      console.log data


