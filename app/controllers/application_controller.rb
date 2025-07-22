class ApplicationController < ActionController::Base
  before_action :confirgure_permitted_parameters, if: :devise_controller?
  allow_browser versions: :modern

  protected

  def confirgure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar ]) # разрешение при обновлении профиля
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :avatar ]) # разрешение при регистрации пользователя
  end
end
