class AddressesController < ApplicationController
  before_action :authenticate_user!

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to edit_user_registration_path, notice: "Address saved!"
    else
      redirect_to edit_user_registration_path, alert: "Please check your address."
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy
    redirect_to edit_user_registration_path, notice: "Address removed."
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :postal_code, :province_id)
  end
end
