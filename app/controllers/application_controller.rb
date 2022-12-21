class ApplicationController < ActionController::Base
  include ApplicationHelper
  include ErrorHandling
  include Pagy::Backend

  add_flash_types :info, :danger, :warning, :success, :alert, :notice
end
