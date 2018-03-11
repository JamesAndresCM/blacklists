class Blacklistip < ApplicationRecord
  require 'resolv'
  validates_presence_of :central_report, :status_ip, :hostname, :url_central_report
  validates :ip_address, :presence => true, :format => { :with => Resolv::IPv4::Regex }

  scope :index_blacklist, -> { where("DATE(created_at) = ?", Date.today).order("ip_address desc") }
  scope :search_blacklist, ->(ip_address) { where("ip_address = ? ","#{ip_address}").order("created_at desc")}

end
