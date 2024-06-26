class PagesController < ApplicationController
  def index
  @categories = Category.all
  @products = Product.page(params[:page]).per(30)

  if params[:category_id].present?
    @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
  end

  if params[:search].present?
    @products = @products.where("products.name LIKE ? OR products.description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  respond_to do |format|
    format.html { render :index }
    format.js
  end
end

  def about
    @about_page = AboutPage.first
  end

  def contact
    @contact_page = ContactPage.first
  end

  def show_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_path, alert: "Product not found"
    end
  end

  def cart
  @cart_products = []
  if session[:cart].present?
    session[:cart].each do |product_id|
      product = Product.find_by(id: product_id)
      @cart_products << product if product
    end
  end
end

  def add_to_cart
    product = Product.find(params[:product_id])
    session[:cart] ||= []
    session[:cart] << product.id
    redirect_back fallback_location: root_path, notice: "Product added to cart"
  end

  def update_cart
  product_id = params[:product_id].to_i
  new_quantity = params[:quantity].to_i

  session[:cart] ||= []

  if new_quantity > 0
    session[:cart].delete(product_id)
    new_quantity.times { session[:cart] << product_id }
  else
    session[:cart].delete(product_id)
  end

  redirect_to cart_path
end

  def remove_from_cart
    product_id = params[:product_id].to_i
    session[:cart].delete(product_id)
    redirect_to cart_path
  end

end

