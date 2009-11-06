class CloudFactoryException < Exception; end

class CloudFactory

  def self.new_from_origin(params)
    case params[:origin]
       when Cloud::ORIGIN['AMAZON']: CloudAmazon.new(params)
       when Cloud::ORIGIN['MYCLOUD']: CloudMycloud.new(params)
       else raise CloudFactoryException.new("No such cloud origin: '#{params[:origin]}'")
    end
  end

end