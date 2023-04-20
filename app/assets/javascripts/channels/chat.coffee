App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'connected to chat channel'
    return

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log 'disconnected from chat channel'
    return

  # Called when there's incoming data on the websocket for this channel  
  # handle incomming data from server which is received by client
  received: (data) ->
    # console.log 'received', data.message
    $('#messages').append data['message']
    return
