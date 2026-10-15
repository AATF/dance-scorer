class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  skip_before_action :require_login, raise: false
  skip_before_action :require_admin, raise: false

  STATUS_DETAILS = {
    400 => {
      title: "Bad Request",
      message: "The server could not understand the request due to invalid syntax or parameters.",
      color: "#d97706",
      bg: "#fef3c7"
    },
    401 => {
      title: "Unauthorized",
      message: "Authentication is required to access this resource. Please log in.",
      color: "#4f46e5",
      bg: "#e0e7ff"
    },
    403 => {
      title: "Access Forbidden",
      message: "You do not have permission to access this resource.",
      color: "#ea580c",
      bg: "#ffedd5"
    },
    404 => {
      title: "Page Not Found",
      message: "The page you are looking for doesn't exist, may have been removed, or is temporarily unavailable.",
      color: "#2563eb",
      bg: "#dbeafe"
    },
    422 => {
      title: "Change Rejected",
      message: "The change you wanted was rejected. The submission was unprocessable or invalid.",
      color: "#d97706",
      bg: "#fef3c7"
    },
    500 => {
      title: "Internal Server Error",
      message: "Something went wrong on our servers while processing your request. Please try again shortly.",
      color: "#dc2626",
      bg: "#fee2e2"
    },
    502 => {
      title: "Bad Gateway",
      message: "The server received an invalid response from an upstream server.",
      color: "#7c3aed",
      bg: "#ede9fe"
    },
    503 => {
      title: "Service Unavailable",
      message: "The application is temporarily unavailable or undergoing maintenance. Please check back soon.",
      color: "#ca8a04",
      bg: "#fef9c3"
    },
    504 => {
      title: "Gateway Timeout",
      message: "The upstream server took too long to respond. Please refresh or try again shortly.",
      color: "#0284c7",
      bg: "#e0f2fe"
    }
  }.freeze

  def show
    raw_code = params[:code] ||
               request.env["action_dispatch.status_code"] ||
               request.path_info.to_s.delete_prefix("/").presence ||
               500

    @status_code = raw_code.to_i
    @status_code = 500 unless (400..599).cover?(@status_code)

    @details = STATUS_DETAILS.fetch(@status_code) do
      {
        title: Rack::Utils::HTTP_STATUS_CODES[@status_code] || "Error",
        message: "An unexpected error occurred (code #{@status_code}).",
        color: "#dc2626",
        bg: "#fee2e2"
      }
    end

    @title = @details[:title]
    @message = @details[:message]

    respond_to do |format|
      format.html { render :show, status: @status_code }
      format.json { render json: { error: @title, message: @message, status: @status_code }, status: @status_code }
      format.any  { render plain: "#{@status_code} #{@title} - #{@message}", status: @status_code, content_type: "text/plain" }
    end
  end

  private

  def current_user
    super
  rescue StandardError
    @current_user = nil
  end
end

