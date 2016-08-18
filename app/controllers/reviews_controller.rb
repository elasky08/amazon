class ReviewsController < ApplicationController
  def create
    @review = Review.new params.require(:review).permit(:body, :rating)
    @q = Product.find params[:product_id]
    @review.product = @q
    if @review.save
      redirect_to product_path(@q), notice: "Review created!"
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
