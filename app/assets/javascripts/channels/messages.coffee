App.messages = App.cable.subscriptions.create channel: "MessagesChannel", chat_id: document.querySelector('head').dataset.chatId,
  connected: ->
    # Called when the subscription is ready for use on the server
    

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # alert(data.content)
    # Called when there's incoming data on the websocket for this channel
    unless(data.content.blank?)
      $("#chat-message").append('<div class="event"><div class="content"><div class="summary message-summary">'+
                                '<i>'+ data.username + ' says : </i>'+data.content+ '</div></div></div>')
      $("#chat_text").val("")
      
      
      $('.content').scrollTop($('.content').prop("scrollHeight"));
      # alert("hello")
      
      
    end