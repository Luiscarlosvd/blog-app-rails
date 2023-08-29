class Users::SessionsController < Devise::SessionsController
  def new
    super
    flash[:notice] = "You can confirm your account email through the link below: #{view_context.link_to('Confirm my account', user_confirmation_url(confirmation_token: current_user.confirmation_token))}" if current_user && !current_user.confirmed?
  end
  def destroy
    super
  end
end