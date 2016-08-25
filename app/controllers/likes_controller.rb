class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    product = Product.find params[:product_id]
    review = Review.find params[:review_id]
    like = Like.new user: current_user, review: review
    if like.save
      redirect_to product_path(product), notice: "Thanks for the like"
    else
      redirect_to product_path(product), alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    product = Product.find params[:product_id]
    review = Review.find params[:review_id]
    like = Like.find params[:id]
    like.destroy
    redirect_to product_path(product), notice: "like removed"
  end
end
