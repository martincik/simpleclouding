# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery :secret => 'efa2779643d19108b00af040b3c2befb'
  filter_parameter_logging :secret_access_key
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  # This is for navigation purpose
  attr_reader :tab_name, :subtab_name
  
  protected
  
    # Automatically respond with 404 for ActiveRecord::RecordNotFound
    def record_not_found
      render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
    end
end
