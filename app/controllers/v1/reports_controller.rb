module V1
  class ReportsController < ApplicationController
    before_action :set_report, only: [:update, :destroy]

    def index
      @report = Report.index_reports
      unless @report.empty?
        json_response(@report)
        else
            json_response(status: "false", message:"records not found")
        end
    end

    #show per id, ! method search by ip_address
    def show
      @report = Report.search_by_id(params[:id])

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

      reports = Report.search_report(ip_address)

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
