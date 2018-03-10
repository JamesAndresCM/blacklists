module V1
  class ReportsController < ApplicationController
    before_action :set_report, only: [:update, :destroy]

    def index
      @reports = Report.all.pluck(:id,:ip_address)
      _report = @reports.map {|id,ip_address| {:id => id, :ip_address => ip_address }}
      json_response(_report)
    end

    #show per id, ! method search by ip_address
    def show
      @report = Report.select(Arel.star).where(Report.arel_table[:id].eq(params[:id])).joins(                                  Report.arel_table.join(Category.arel_table).on(Report.arel_table[:id].eq(
                Category.arel_table[:report_id])).join_sources)

      check_report = Report.where("id = ?",params[:id])

      unless @report.empty?
        json_response(@report)
        else if not check_report.empty?
             json_response({status: "404",message: "#{params[:id]} not record category asociated"})
        else
              json_response({ status: "404", message: "#{params[:id]} not found"})
             end
        end
    end

    def destroy
      @report.destroy
      json_response({ status: "OK", message: "row deleted"})
    end

    def create
      @report = Report.new(report_params)
      unless params[:category_ip_blacklist].nil? or @report.nil?
        @report.save!
        @report.categories.create(report_id: @report.id, category_ip_blacklist: params[:category_ip_blacklist])
        @report.save!
        json_response(@report, :created)
      else if not @report.nil?
        json_response(status:"error category_ip_blacklist not blank")
        end
      end
    end

    def update
      @report.update(report_params)
      json_response({ status: "OK", message: "row updated"})
    end

    def search_ip
      ip_address = params[:ip_address] || nil

=begin
      reports = Report.find_by("ip_address= '#{ip_address}'")

      #equivalente en sql
      # #reports = Report.find_by_sql("select * from reports inner
      #join categories on reports.id=categories.report_id  where ip_address='#{ip_address}'")
=end
      #query orm
      reports = Report.select(Arel.star).where(Report.arel_table[:ip_address].eq("#{ip_address}")).joins(                      Report.arel_table.join(Category.arel_table).on(Report.arel_table[:id].eq(
                Category.arel_table[:report_id])).join_sources)

      check_report = Report.find_by("ip_address = ? ",ip_address)

      unless reports.empty?
        json_response(reports)
        else if not check_report.nil?
             json_response({status: "404",message: "#{ip_address} not record category asociated"})
        else
          json_response({ status: "404", message: "#{ip_address} not found"})
             end
      end
    end

    private

    def report_params
      params.require(:report).permit(:ip_address, :isWhitelisted ,categories_attributes: [:report_id, :category_ip_blacklist])
    end

    def set_report
      @report = Report.find(params[:id])
    end
  end
end
