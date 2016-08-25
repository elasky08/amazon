class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find params[:product_id]
    favourite = Favourite.new user: current_user, product: product
    if favourite.save
      redirect_to product_path(product), notice: "Thanks for favourite"
    else
      redirect_to product_path(product), alert: favourite.errors.full_messages.join(", ")
    end
  end

  def destroy
    product = Product.find params[:product_id]
    favourite = Favourite.find params[:id]
    favourite.destroy
    redirect_to product_path(product), notice: "favourite removed"
  end
end
