class DashboardController < ApplicationController

  before_filter :setup_tabs

  def index
  end

  protected

    def setup_tabs
      @tab_name = 'manage'
      @subtab_name = 'clouds'
    end

end
