class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :new]
  PRODUCTS_PER_PAGE = 10
  def show
    @product = Product.find params[:id]
    @products2 = Product.search(params[:search_term])
    @products = @products2.order(created_at: :desc).
                           page(params[:page]).
                           per(PRODUCTS_PER_PAGE)
    @review = Review.new
    @category = @product.category #Category.find params[@q.category_id]
  end

  def index

    @products2 = Product.search(params[:search_term])
    @products = @products2.order(created_at: :desc).
                           page(params[:page]).
                           per(PRODUCTS_PER_PAGE)
    # @products = Product.latest.paginate(:page => params[:page])
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
    # @user = User.all
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])
    @product       = Product.new product_params
    @product.user = current_user
    # @product       = current_user.products.new product_params
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
