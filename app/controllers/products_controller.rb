class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :filter_products
  before_action :refresh_products, only: :index
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = params[:category].present? ? Product.where(category: params[:category]) : Product.all
  end

  # @todo can't get @products to update in the view with filtered collection
  def filter_products
    @products = params[:category] ? Product.where(category: params[:category]) : Product.all
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_url }
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def success; end
  def cancel; end

  private

    def refresh_products # I have the Products/Prices in Stripe. Also have them in postgres db. Commenting out for now.
      Product.destroy_all
      response = Faraday.get('https://fakestoreapi.com/products')
      if response.success?
        products = JSON.parse(response.body).map{ |product_hash| product_hash.transform_keys('id' => 'lookup_key') }

        # create Stripe Prices and Products; swallow any duplicate Product creation attempts
        products.each do |product|
          stripe_product = Stripe::Product.create({
                                                      id: product['lookup_key'],
                                                      name: product['title'],
                                                      description: product['description'].truncate(500),
                                                      images: Array(product['image']),
                                                      metadata: {
                                                          lookup_key: product['lookup_key'].to_s,
                                                          category: product['category'],
                                                          rate: product.dig('rating', 'rate'),
                                                          count: product.dig('rating', 'count')
                                                      }
                                                  })
          Stripe::Price.create({
                                   currency: 'usd',
                                   product: stripe_product.id,
                                   unit_amount: (product['price']*100).to_i, # expects an integer representation, so $1.00 is 100
                                   lookup_key: product['lookup_key'].to_s
                               })
        rescue Stripe::InvalidRequestError => e
          if /already uses that lookup key/.match?(e.message)
            next
          elsif /Product already exists./.match?(e.message)
            next
          else
            raise e
          end
        end
        Product.create!(products)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, :description, :category, :image, :rating)
    end
end
