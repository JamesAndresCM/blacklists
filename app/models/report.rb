class Report < ApplicationRecord
  require 'resolv'
  has_many :categories, dependent: :destroy, inverse_of: :report
  validates_presence_of :isWhitelisted
  validates_presence_of :ip_address, :format => { :with => Resolv::IPv4::Regex }
  accepts_nested_attributes_for :categories

  scope :index_reports, -> { select(:ip_address, :id).group(:ip_address).order("created_at desc").as_json }

  def self.search_report(ip_address)
    self.select(Arel.star).where(self.arel_table[:ip_address].eq("#{ip_address}")).joins(
        self.arel_table.join(Category.arel_table).on(self.arel_table[:id].eq(
        Category.arel_table[:report_id])).join_sources).group(:category_ip_blacklist).order(
        "reports.created_at desc")
  end


  def self.search_by_id(id)
    self.select(Arel.star).where(self.arel_table[:id].eq("#{id}")).joins(
        self.arel_table.join(Category.arel_table).on(self.arel_table[:id].eq(
        Category.arel_table[:report_id])).join_sources)
  end

end
