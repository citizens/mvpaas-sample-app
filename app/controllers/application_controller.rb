class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_user
    request.env['warden'].authenticate(:mvpaas)
    @user = request.env['warden'].user
    redirect_to_login if @user.nil?
  end

  def redirect_to_login
    redirect_to "#{ENV['MVPAAS_URL']}/sign_in.html"
  end
end
