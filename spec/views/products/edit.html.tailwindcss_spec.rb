require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      title: "MyString",
      price: 1.5,
      description: "MyString",
      category: "MyString",
      image: "MyString",
      rating: ""
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input[name=?]", "product[title]"

      assert_select "input[name=?]", "product[price]"

      assert_select "input[name=?]", "product[description]"

      assert_select "input[name=?]", "product[category]"

      assert_select "input[name=?]", "product[image]"

      assert_select "input[name=?]", "product[rating]"
    end
  end
end
