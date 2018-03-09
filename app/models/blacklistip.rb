class Blacklistip < ApplicationRecord
  require 'resolv'
  validates_presence_of :central_report, :status_ip, :hostname, :url_central_report
  validates :ip_address, :presence => true, :format => { :with => Resolv::IPv4::Regex }
end
