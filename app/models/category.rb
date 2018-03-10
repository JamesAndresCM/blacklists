class Category < ApplicationRecord
  belongs_to :report, inverse_of: :categories
  validates_presence_of :category_ip_blacklist
end
