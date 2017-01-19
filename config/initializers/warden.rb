require 'mvpaas'

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :mvpaas
  manager.failure_app = 'ApplicationController'
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find(:first, :conditions => { :id => id })
  end
end

Warden::Strategies.add(:mvpaas) do
  # If the token is invalid, an exception will be raised.
  # Create or find a new user based on MVPaaS ID
  def authenticate!
    data = MVPaaS::Auth.decode(params[:token], ENV['MVPAAS_SECRET'])
    user = User.find_or_initialize_by(external_id: data[:id])

    if user.new_record?
      user.email = data[:email]
      user.save
    end

    success!(user)
  rescue JWT::DecodeError
    fail!
  end
end
