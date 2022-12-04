class ApplicationController < ActionController::Base
  include ErrorHandling
  include ApplicationHelper
  
  add_flash_types :info, :danger, :warning, :success, :alert, :notice
  
end
