require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      title: "MyString",
      price: 1.5,
      description: "MyString",
      category: "MyString",
      image: "MyString",
      rating: ""
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input[name=?]", "product[title]"

      assert_select "input[name=?]", "product[price]"

      assert_select "input[name=?]", "product[description]"

      assert_select "input[name=?]", "product[category]"

      assert_select "input[name=?]", "product[image]"

      assert_select "input[name=?]", "product[rating]"
    end
  end
end
