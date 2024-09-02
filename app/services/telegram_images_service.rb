class TelegramImagesService
  include Service

  TELEGRAM_API_URL = 'https://api.telegram.org'.freeze

  def call
    images.map do |image|
      file_path = get_file(image.telegram_id)['result']['file_path']

      "#{TELEGRAM_API_URL}/file/bot#{Telegram.bot.token}/#{file_path}"
    end
  end

  private

  def get_file(telegram_id)
    url = URI("#{TELEGRAM_API_URL}/bot#{Telegram.bot.token}/getFile?file_id=#{telegram_id}")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  end
  attr_accessor :images
end
