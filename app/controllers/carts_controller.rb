class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @cart_items = @cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      { product: product, quantity: quantity } if product
    end.compact
  end

  def add
    @cart = session[:cart] || {}
    product_id = params[:product_id].to_s
    @cart[product_id] = (@cart[product_id] || 0) + 1
    session[:cart] = @cart
    redirect_to cart_path, notice: "Item added to cart!"
  end

  def remove
    @cart = session[:cart] || {}
    @cart.delete(params[:product_id].to_s)
    session[:cart] = @cart
    redirect_to cart_path, notice: "Item removed from cart!"
  end

  def update
    @cart = session[:cart] || {}
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    if quantity > 0
      @cart[product_id] = quantity
    else
      @cart.delete(product_id)
    end
    session[:cart] = @cart
    redirect_to cart_path
  end
end
