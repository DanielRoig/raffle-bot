class SendMessageService
  include Service

  def call
    Array.wrap(message).each do |msg|
      case msg.type
      when 'text'
        if msg.action == 'edit' && update['callback_query']
          edit_text_message(msg)
        end
        if msg.action == 'new' || update['callback_query'].nil?
          send_text_message(msg)
        end
      when 'photo'
        if msg.action == 'edit_buttons'
          edit_photo_buttons(msg)
        else
          send_photo_message(msg)
        end
      end
    end
  end

  private

  def send_text_message(msg)
    Telegram.bot.send_message(
      chat_id: chat['id'],
      text: msg.text,
      reply_markup: { inline_keyboard: msg.buttons }
    )
  end

  def edit_text_message(msg)
    Telegram.bot.edit_message_text(
      text: msg.text,
      chat_id: chat['id'],
      message_id: update['callback_query']['message']['message_id'],
      reply_markup: { inline_keyboard: msg.buttons }
    )
  end

  def send_photo_message(msg)
    tempfile = FileContentService.call(image_url: msg.image_url)
    Telegram.bot.send_photo(
      chat_id: chat['id'],
      photo: tempfile,
      caption: msg&.text,
      reply_markup: { inline_keyboard: msg&.buttons }
    )
    tempfile.close
  end

  def edit_photo_buttons(msg)
    Telegram.bot.edit_message_reply_markup(
      chat_id: chat['id'],
      message_id: update['callback_query']['message']['message_id'],
      reply_markup: { inline_keyboard: msg.buttons }
    )
  end

  attr_accessor :message, :update, :chat
end
