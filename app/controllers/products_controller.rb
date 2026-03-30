class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:filter] == "on_sale"
      @products = @products.where(on_sale: true)
    elsif params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "updated"
      @products = @products.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
    end

    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(12)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
