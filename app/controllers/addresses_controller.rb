
class AddressesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @address = @user.address || @user.build_address
  end

  def update
    @user = current_user
    @address = @user.address || @user.build_address
    if @address.update(address_params)
      redirect_to root_path, notice: "Address updated successfully."
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:street_address, :city, :postal_code, :province)
  end
end
