class AppMonitorController < ApplicationController
  
  def exception
    raise(Exception, "Forced Exception from AppMonitorController")
  end

end
