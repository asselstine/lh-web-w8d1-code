class OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2

    email = request.env['omniauth.auth']['info']['email']

    user = User.where(:email => email).first_or_create do |user|
      user.email = email
      user.save
    end

    if user.persisted?
      sign_in_and_redirect user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      flash[:error] = 'this did not work'
      redirect_to '/'
    end
  end
end
