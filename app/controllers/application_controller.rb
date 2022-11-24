class ApplicationController < ActionController::Base
  helper_method :i18n_model_name

  add_flash_types :info, :danger, :warning, :success, :alert, :notice
  
  private
    
    def i18n_model_name(model)
      model.model_name.human
    end
end
