class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit_address
  end

  def update_address
    if current_user.update(user_params)
      redirect_to root_path, notice: "Address updated successfully."
    else
      render :edit_address
    end
  end

  private

  def user_params
    params.require(:user).permit(:street_address, :city, :postal_code)
  end
end
