json.form render(partial: "messages/new_message", formats: :html, locals: {message: Message.new, challenge: @challenge})
json.inserted_item render(partial: "messages/message", formats: :html, locals: {message: @message})
