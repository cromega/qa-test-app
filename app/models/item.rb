class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 60 }
  validates :description, presence: true
  validates :category, presence: true, format: { with: /\A[a-zA-Z ]*\z/, message: "may only contain letters and spaces" }

  def self.all_categories
    Item.pluck("DISTINCT category")
  end
end
