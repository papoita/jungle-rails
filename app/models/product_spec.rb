require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'has name, price, quantity and category to be saved' do
      @category = Category.new(name: "Sports Equipment")
      @product = @category.products.new({
        name: "Swim suit",
        price: 8,
        quantity: 10
      })
      expect(@product).to be_valid 
    end

    it 'Not valid without product name' do
      @category = Category.new(name: "Sports Equipment")
      @product = @category.products.new({
        name: nil,
        price: 8,
        quantity: 10
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Product needs a name"
    end

    it 'Not valid without a price' do
      @category = Category.new(name: "Sports Equipment")
      @product = @category.products.new({
        name: "Swim suit",
        price: nil,
        quantity: 10
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Product needs a price"
    end

    it 'Not valid without a quantity' do
      @category = Category.new(name: "Test Category")
      @product = @category.products.new({
        name: "Swim suit",
        price: 8,
        quantity: nil
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Product neeeds a quantity"
    end

    it 'Not valid without a category' do
      @product = Product.new({
        name: "Test Product",
        price: 8,
        quantity: 10, 
        category: nil
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Product needs a category"
    end
  end
end