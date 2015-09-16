class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :sanitize_page_params

  private

  def sanitize_page_params
    params[:quantity] = params[:quantity].to_i if params[:quantity]
    params[:unit_price] = params[:unit_price].to_i if params[:unit_price]
  end
end
