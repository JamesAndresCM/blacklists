class Report < ApplicationRecord
  require 'resolv'
  has_many :categories, dependent: :destroy
  validates_presence_of :isWhitelisted
  validates :ip_address, :presence => true, :format => { :with => Resolv::IPv4::Regex }
end
