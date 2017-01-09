require 'rails_helper'

describe Item, type: :model do
  describe "attributes" do
    describe "name" do
      it "needs to be present" do
        item = Item.new(name: "", description: "test", category: "test").tap { |i| i.validate }
        expect(item.errors.full_messages).to include "Name can't be blank"
      end

      it "needs to be max 60 characters long" do
        item = Item.new(name: "a"*61, description: "test", category: "test").tap { |i| i.validate }
        expect(item.errors.full_messages).to include "Name is too long (maximum is 60 characters)"
      end
    end

    describe "description" do
      it "needs to be present" do
        item = Item.new(name: "test", description: "", category: "test").tap { |i| i.validate }
        expect(item.errors.full_messages).to include "Description can't be blank"
      end
    end

    describe "category" do
      it "needs to be present" do
        item = Item.new(name: "test", description: "test", category: "").tap { |i| i.validate }
        expect(item.errors.full_messages).to include "Category can't be blank"
      end

      it "does only allows letters and spaces" do
        item = Item.new(name: "test", description: "test", category: "cat123").tap { |i| i.validate }
        expect(item.errors.full_messages).to include "Category may only contain letters and spaces"
      end
    end
  end

  describe ".all_categories" do
    before do
      create(:item, category: "category A")
      create(:item, category: "category B")
      create(:item, category: "category A")
    end

    it "returns a list of all existing categories" do
      expect(Item.all_categories).to eq ["category A", "category B"]
    end
  end
end
