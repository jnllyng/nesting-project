class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = session[:cart] || {}
    if @cart.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end
    @cart_items = build_cart_items(@cart)
    @provinces = Province.all.order(:name)
    @address = current_user.addresses.last || Address.new
  end

  def create
    @cart = session[:cart] || {}
    @cart_items = build_cart_items(@cart)
    @provinces = Province.all.order(:name)

    @address = Address.new(address_params)
    @address.user = current_user

    if params[:save_address] == "1" && @address.save
      # saved
    elsif !@address.valid?
      render :new and return
    end

    province = Province.find(address_params[:province_id])
    subtotal = @cart_items.sum { |item| item[:product].price * item[:quantity] }
    gst = (subtotal * province.gst).round(2)
    pst = (subtotal * province.pst).round(2)
    hst = (subtotal * province.hst).round(2)
    total = (subtotal + gst + pst + hst).round(2)

    session[:checkout] = {
      address: address_params.to_h,
      province_id: province.id,
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      total: total
    }

    redirect_to confirm_checkout_path
  end

  def confirm
    @cart = session[:cart] || {}
    @cart_items = build_cart_items(@cart)
    @checkout = session[:checkout]
    @province = Province.find(@checkout["province_id"])

    if @cart.empty? || @checkout.nil?
      redirect_to cart_path and return
    end
  end

  def complete
    @cart = session[:cart] || {}
    @checkout = session[:checkout]
    @cart_items = build_cart_items(@cart)

    address_data = @checkout["address"]
    province = Province.find(@checkout["province_id"])

    address = current_user.addresses.find_or_create_by(
      street: address_data["street"],
      city: address_data["city"],
      postal_code: address_data["postal_code"],
      province: province
    )

    order = Order.create!(
      user: current_user,
      address: address,
      province: province,
      status: "new",
      total: @checkout["total"],
      gst_rate: province.gst,
      pst_rate: province.pst,
      hst_rate: province.hst
    )

    @cart_items.each do |item|
      OrderItem.create!(
        order: order,
        product: item[:product],
        quantity: item[:quantity],
        item_price: item[:product].price
      )
    end

    session[:cart] = {}
    session[:checkout] = nil

    redirect_to root_path, notice: "Order placed successfully! Order ##{order.id}"
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :postal_code, :province_id)
    rescue ActionController::ParameterMissing
    params.permit(:street, :city, :postal_code, :province_id)
  end

  def build_cart_items(cart)
    cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      { product: product, quantity: quantity } if product
    end.compact
  end
end
