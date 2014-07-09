class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, with: :render_generic_exception # make sure the generic Exception handler is at the top
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActionController::UnknownController, with: :render_not_found
  rescue_from AbstractController::ActionNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_generic_exception(exception)
    render_exception(500, exception.message, exception)
  end

  def method_missing(method, *args)
    render template: "static/error_no_method", formats: [:html], layout: 'application'
  end

  def render_not_found(exception = nil)
    render_exception(404, 'Not Found', exception)
  end

  def render_exception(status = 500, message = 'An Error Occurred', exception)
    @status = status
    @message = message
    # email = UserMailer.exception_notify(exception,exception.backtrace.join("\n")).deliver
    render template: "static/error", formats: [:html], layout: 'application', status: @status
  end

def error_routing
  render template: "static/error_no_method", formats: [:html], layout: 'application'
end
end
