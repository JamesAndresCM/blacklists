class ApplicationController < ActionController::API
    include ExceptionHandler
    include Response
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found(exception)
        json_response({ status: "404", "#{exception.message}": "page not found"})
    end
end
