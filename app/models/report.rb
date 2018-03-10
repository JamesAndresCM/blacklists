class Report < ApplicationRecord
  require 'resolv'
  has_many :categories, dependent: :destroy, inverse_of: :report
  validates_presence_of :isWhitelisted
  validates_presence_of :ip_address, :format => { :with => Resolv::IPv4::Regex }
  accepts_nested_attributes_for :categories
end
