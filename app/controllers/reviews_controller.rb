class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :new]
  def create
    @review = Review.new params.require(:review).permit(:body, :rating)
    @product = Product.find params[:product_id]
    @review.product = @product
    if @review.save
      redirect_to product_path(@product), notice: "Review created!"
    else
      flash[:alert] = "Please fix errors below"
      render "/products/show"
    end
  end

  def destroy
    a = Product.find params[:product_id]
    r = Review.find params[:id]
    r.destroy
    redirect_to product_path(a), notice: "Review deleted!"
  end
end
