class ProductsController < ApplicationController
  def show
    @q = Product.find params[:id]
    @review = Review.new
    @category = @q.category #Category.find params[@q.category_id]
  end

  def index
    # @products = Product.order(created_at: :desc)
    @products = Product.latest.paginate(:page => params[:page])
    # Product.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @product = Product.find params[:id]

  end

  def update
    @product = Product.find params[:id]
    if @product.update params.require(:product).permit([:title, :description, :price])
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def new
    @product = Product.new
    @category = Category.all
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])
    @product       = Product.new product_params

    if @product.save
      redirect_to product_path(@product), notice: "Product created!"
    else
      render :new
    end
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end
end
