module Message
  class Message
    def initialize(text, buttons = [], type = 'text', action = 'edit', image_url = nil)
      @text = text
      @buttons = buttons
      @type = type
      @image_url = image_url
      @action = action
    end

    attr_reader :text, :buttons, :type, :image_url, :action
  end
end
