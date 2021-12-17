require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        title: "Title",
        price: 2.5,
        description: "Description",
        category: "Category",
        image: "Image",
        rating: ""
      ),
      Product.create!(
        title: "Title",
        price: 2.5,
        description: "Description",
        category: "Category",
        image: "Image",
        rating: ""
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Category".to_s, count: 2
    assert_select "tr>td", text: "Image".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
