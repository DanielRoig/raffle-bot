class RaffleController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(value = nil, *)
    callback_query('show_raffle_description_new')
  end

  def delete!(value = nil, *)
    callback_query('admin_delete_raffle')
  end

  def callback_query(data)
      RaffleServices::AdminCreateService.new(session:).clear_session if session[:creating_raffle]
      RaffleServices::AdminEditService.new(session:).clear_session if session[:editing_raffle]
      RaffleServices::UploadPaymentImageService.new(session:).clear_session if session[:uploading_payment_image]

    message = case data
              when /^show_raffle_description_(\w+)$/
                RaffleServices::ShowDescriptionService.call(raffle: current_raffle, user: current_user, message_action: $1)
              when 'show_raffle_photos'
                RaffleServices::SendImagesService.call(raffle: current_raffle, user: current_user)
              when /^admin_show_verify_payments_(\d+)_(\w+)$/
                NumberServices::AdminShowUsersService.call(raffle: current_raffle, current_user:, message_action: $2, page: $1.to_i)
              when /^admin_show_payment_image_(\d+)(?:_(\d+)_([\w]+))?$/
                user_id = $1.to_i
                number_id = $2 ? $2.to_i : nil
                new_status = $3 || nil
                NumberServices::AdminShowPaymentImage.call(raffle: current_raffle, current_user:, user_id:, number_id:, new_status:)
              when /^admin_numbers_(\w+)$/
                NumberServices::AdminShowService.call(raffle: current_raffle, user: current_user, value: $1.to_i)
              when /^admin_update_number_status_(\w+)_(\d+)$/
                NumberServices::AdminUpdateStatusService.call(value: $2.to_i, status: $1, raffle: current_raffle, user: current_user)
              when 'admin_create_raffle'
                RaffleServices::AdminCreateService.new(session:, user: current_user).start_creation
              when 'admin_edit_raffle'
                RaffleServices::AdminEditService.new(session:, user: current_user, raffle: current_raffle).start_edit
              when 'admin_delete_raffle'
                RaffleServices::AdminDeleteService.call(raffle: current_raffle, user: current_user)
              when 'admin_show_raffle_status'
                RaffleServices::AdminShowStatusService.call(raffle: current_raffle, user: current_user)    
              when 'admin_show_raffle_summary'
                RaffleServices::AdminSummarizeService.call(raffle: current_raffle, user: current_user)
              when /^show_(\w+)_numbers_(\d+)$/
                NumberServices::ShowGridService.call(raffle: current_raffle, type: $1, page: $2.to_i, user: current_user)
              when 'show_payment_funnel'
                RaffleServices::ShowPaymentFunnelService.call(raffle: current_raffle, user: current_user, session:)
              when /^admin_update_raffle_status_(\w+)$/
                RaffleServices::AdminUpdateStatusService.call(status: $1, raffle: current_raffle, user: current_user)
              when /^reserved_numbers_(\d+)$/
                NumberServices::ReleaseService.call(raffle: current_raffle, user: current_user, value: $1.to_i)
              when /^available_numbers_(\d+)$/
                NumberServices::TakeService.call(raffle: current_raffle, user: current_user, value: $1.to_i)
              end
    
    SendMessageService.call(message:, update:, chat:)  
  end

  def message(message)
    if session[:creating_raffle]
      messagee = RaffleServices::AdminCreateService.new(session:, message:, user: current_user).process_response
      SendMessageService.call(message: messagee, update:, chat:) 
    end
    if session[:editing_raffle]
      messagee = RaffleServices::AdminEditService.new(
        session:, 
        message:, 
        user: current_user, 
        raffle: current_raffle
      ).process_response
      SendMessageService.call(message: messagee, update:, chat:)  
    end
    if session[:uploading_payment_image]
      messagee =RaffleServices::UploadPaymentImageService.call(
        message: message, 
        user: current_user, 
        session:)
      SendMessageService.call(
        message: messagee, 
        update:, 
        chat:)
    end
  end

  def current_raffle
    @raffle ||= Raffle.first
  end

  def current_user
    @user ||= User.find_or_create_by(telegram_id: from['id'], telegram_username: from['username'], telegram_first_name: from['first_name'])
  end
end
