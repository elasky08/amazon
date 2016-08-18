require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new campaign instance variable" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    describe "#create" do
      context "with valid parameters" do
        def valid_request
          post :create, params: { product: {title: "product title",
                                            description: "info for product",
                                            price: 100}}
        end
        it "saves the record to the database" do
          count_before = Product.count
          valid_request
          count_after = Product.count
          expect(count_after).to eq(count_before + 1)
        end
        it "redirects to the product show page" do
          valid_request
          expect(response).to redirect_to(product_path(Product.last))
        end
        it "sets a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, params: {product: {title: ""}}
        end
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "doesn't save the record to the database" do
          count_before = Product.count
          invalid_request
          count_after = Product.count
          expect(count_after).to eq(count_before)
        end
      end

      describe "#edit" do
          it "renders the show template" do
            product = FactoryGirl.create(:product)
            get :edit, params: {id: product.id}
            expect(response).to render_template(:edit)
          end
        end

      describe "#update" do
        context "with valid parameters" do
          def valid_request
            post :create, params: {product: {title: "product title",
                                             description: "hispter blah",
                                             price: 100}}
          end
          it "saves the record to the database" do
            count_before = Product.count
            valid_request
            expect(flash[:notice]).to be
          end
          it "redirects to the product show page" do
            valid_request
            expect(response).to redirect_to(product_path(Product.last))
          end

          context "with invalid parameters" do
            def invalid_request
              post :create, params: {product: {title: ""}}
            end
            it "renders the new template" do
              invalid_request
              expect(response).to render_template(:new)
            end
            it "doesn't save the record to the database" do
              count_before = Product.count
              invalid_request
              count_after = Product.count
              expect(count_after).to eq(count_before)
            end
          end
        end
      end

    end
  end

end
