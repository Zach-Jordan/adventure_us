class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to confirm_order_path(@order)
    else
      render :new
    end
  end

  def confirm
  if request.post?
    @order = Order.find(params[:id])
    @cart_products = get_cart_products
    @cart_counts = get_cart_counts
    @subtotal = calculate_subtotal
    @tax_rate = calculate_tax_rate(@order.province)
    @tax_amount = @subtotal * @tax_rate
    @total = @subtotal + @tax_amount

    # Assuming the order is confirmed successfully, redirect to thank_you action
    redirect_to thank_you_order_path
  else
    # Handle GET request to show confirmation page
    @order = Order.find(params[:id])
    @cart_products = get_cart_products
    @cart_counts = get_cart_counts
    @subtotal = calculate_subtotal
    @tax_rate = calculate_tax_rate(@order.province)
    @tax_amount = @subtotal * @tax_rate
    @total = @subtotal + @tax_amount
  end
end

  def thank_you
    # Display thank you message
  end

  private

  def order_params
    params.require(:order).permit(:address, :province, :other_order_details)
  end

  def get_cart_products
    product_ids = session[:cart]
    Product.where(id: product_ids)
  end

  def get_cart_counts
    product_ids = session[:cart]
    product_ids.each_with_object(Hash.new(0)) { |id, counts| counts[id] += 1 }
  end

  def calculate_subtotal
    @cart_products.map { |product| product.price * @cart_counts[product.id] }.sum
  end

  def calculate_tax_rate(province)
    case province
  when "Alberta"
    0.05 # GST (5%)
  when "British Columbia"
    0.12 # PST (7%) + GST (5%)
  when "Manitoba"
    0.13 # PST (7%) + GST (5%)
  when "New Brunswick"
    0.15 # HST (15%)
  when "Newfoundland and Labrador"
    0.15 # HST (15%)
  when "Nova Scotia"
    0.15 # HST (15%)
  when "Ontario"
    0.13 # HST (13%)
  when "Prince Edward Island"
    0.15 # HST (15%)
  when "Quebec"
    0.14975 # QST (9.975%) + GST (5%)
  when "Saskatchewan"
    0.11 # PST (6%) + GST (5%)
  when "Northwest Territories"
    0.05 # GST (5%)
  when "Nunavut"
    0.05 # GST (5%)
  when "Yukon"
    0.05 # GST (5%)
  else
    0.05 # Default tax rate for provinces not specified
  end
  end
end
