class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @product = Product.find params[:product_id]
    @review = Review.find params[:review_id]
    @like = Like.new user: current_user, review: @review
    respond_to do |format|
      if @like.save
        format.html {redirect_to product_path(@review.product_id), notice: "Thanks for the like"}
        format.js { render }
      else
        format.html {redirect_to product_path(@review.product_id), alert: like.errors.full_messages.join(", ")}
        format.js {render}
      end
    end
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:review_id]
    @like = Like.find params[:id]
    @like.destroy
    respond_to do |format|
      format.html {redirect_to product_path(@product), notice: "like removed"}
      format.js { render }
    end
  end
end
