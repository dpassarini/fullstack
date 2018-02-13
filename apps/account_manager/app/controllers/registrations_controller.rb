class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: user.errors.first, status: 406
    end
  end

  private
  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation, :document)
  end
end
