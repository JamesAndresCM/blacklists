module V1
    class BlacklistipsController < ApplicationController
      before_action :set_blacklist, only: [:destroy]

      def index
        @blacklistips = Blacklistip.all.order("created_at desc")
        unless @blacklistips.empty?
            json_response(@blacklistips)
            else
                json_response(status:"false", message: "records not found")
            end
      end

      def create
        @blacklistips = Blacklistip.create!(blacklist_params)
        json_response(@blacklistips, :created)
      end

      def search_blacklist
        ip_address = params[:ip_address] || nil

        blacklist = Blacklistip.where("ip_address = ? ",ip_address).order("created_at desc")

        unless blacklist.empty? or blacklist.nil?
          json_response(blacklist)
        else
          json_response({ status: "404", message: "#{ip_address} not found"})
        end
      end

      def destroy
        @blacklistip.destroy
        json_response({ status: "OK", message: "row deleted"})
      end

      private

      def blacklist_params
        params.permit(:ip_address, :central_report, :hostname, :status_ip, :url_central_report)
      end

      def set_blacklist
        @blacklistip = Blacklistip.find(params[:id])
      end

    end
end
