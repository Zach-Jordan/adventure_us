class PagesController < ApplicationController
  def index
    @categories = Category.all
    if params[:category_id].present?
      @products = Category.find(params[:category_id]).products
    else
      @products = Product.all
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

end

