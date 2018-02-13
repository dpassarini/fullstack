class ApplicationController < ActionController::API
  def current_user
    if doorkeeper_token
      return User.find(doorkeeper_token[:resource_owner_id])
    end
    nil
  end
end
