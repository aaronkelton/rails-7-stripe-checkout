class AddLookupKeyToProducts < ActiveRecord::Migration[7.0]
  def change
    # Stripe::Price lookup_key is string up to 200 characters
    add_column :products, :lookup_key, :string, limit: 200

    # Also, because of the column name ending in _key, we get automatic log filtering. See filter_parameter_logging.rb initializer
    # #<Product:0x00007fd4eef514a8
    #  id: 41,
    #  title: "DANVOUY Womens T Shirt Casual Cotton Short",
    #  price: 12.99,
    #  description:
    #   "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
    #  category: "women's clothing",
    #  image: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
    #  rating: {"rate"=>3.6, "count"=>145},
    #  created_at: Sun, 19 Dec 2021 21:19:03.448857000 UTC +00:00,
    #  updated_at: Sun, 19 Dec 2021 21:19:03.448857000 UTC +00:00,
    #  lookup_key: "[FILTERED]">
  end
end
