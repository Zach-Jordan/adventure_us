class OrdersController < ApplicationController
 before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def shipping
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      session[:cart].each do |product_id, quantity|
        @order.order_items.create(product_id: product_id, quantity: quantity)
      end
      redirect_to confirm_order_path(@order)
    else
      render :new
    end
  end

  def confirm
    if request.post?
      # Handle POST request to confirm order
      @order = Order.find(params[:id])
      @cart_products = get_cart_products
      @cart_counts = get_cart_counts
      @subtotal = calculate_subtotal
      @tax_rate = calculate_tax_rate(@order.province)
      @tax_amount = @subtotal * @tax_rate
      @total = @subtotal + @tax_amount

      # Update order attributes
      @order.subtotal = @subtotal
      @order.tax_amount = @tax_amount
      @order.total = @total

      # Save the order
      if @order.save
        redirect_to thank_you_order_path
      else
        # Handle error if order fails to save
        render :confirm
      end
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

 def process_payment
  @order = Order.find(params[:id])
  Stripe.api_key = 'sk_test_51P8uaqG3PBAJvQWNSHMuLXTUVDCka6wm2orJCzFw6Q2W5uEI3MLa3jqtWOlkZaE31BxGGokVQ5JrbWw9hmjfzhHt00xW2aUw54'

      @order = Order.find(params[:id])
  @cart_products = get_cart_products
  @cart_counts = get_cart_counts
  @subtotal = calculate_subtotal
  @tax_rate = calculate_tax_rate(@order.province)
  @tax_amount = @subtotal * @tax_rate
  @total = @subtotal + @tax_amount
  @order.total = @total

  begin
    charge = Stripe::Charge.create(
      amount: (@order.total * 100).to_i,
      currency: 'cad',
      source: params[:stripeToken],
      description: 'Payment for Order'
    )

    # Create order only if payment is successful
    if charge.paid
      # Update order attributes
      @order.subtotal = @subtotal
      @order.tax_amount = @tax_amount
      @order.total = @total

      # Save the order
      if @order.save
        session[:cart] = [] # Clear the cart after successful order placement
        redirect_to thank_you_order_path
      else
        # Handle error if order fails to save
        render :confirm
      end
    else
      # Handle case where payment is not successful
      # You might want to redirect the user back to the payment page or handle it in another way
      flash[:error] = "Payment was not successful. Please try again."
      redirect_to confirm_order_path(@order)
    end
  rescue Stripe::CardError => e
    # Handle Stripe errors, such as card declines
    flash[:error] = e.message
    redirect_to confirm_order_path(@order)
  end
end

  def thank_you
    session[:cart] = []
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
