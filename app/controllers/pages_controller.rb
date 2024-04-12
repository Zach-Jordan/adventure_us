class PagesController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all
    if params[:search].present?
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    if params[:category_id].present?
      @products = Category.find(params[:category_id]).products & @products
    end
    respond_to do |format|
      format.html { render :index }

      format.js # This will render index.js.erb
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
    session[:cart] ||= []  # Initialize cart in session if it doesn't exist
    session[:cart] << product.id  # Add product to cart
    redirect_to root_path, notice: "Product added to cart"
  end

  def update_cart
  product_id = params[:product_id].to_i
  new_quantity = params[:quantity].to_i

  session[:cart] ||= []

  if new_quantity > 0
    session[:cart].delete(product_id)  # Remove any existing entry for this product
    new_quantity.times { session[:cart] << product_id }  # Add the product to the session with the new quantity
  else
    session[:cart].delete(product_id)  # Remove the product from the session if the quantity is 0
  end

  redirect_to cart_path
end


  # Action to remove an item from the cart
  def remove_from_cart
    product_id = params[:product_id].to_i
    session[:cart].delete(product_id)
    redirect_to cart_path
  end

end

