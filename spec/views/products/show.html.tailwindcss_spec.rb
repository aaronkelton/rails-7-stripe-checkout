require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      title: "Title",
      price: 2.5,
      description: "Description",
      category: "Category",
      image: "Image",
      rating: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(//)
  end
end
