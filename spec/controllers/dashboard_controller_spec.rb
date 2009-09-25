require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DashboardController do

  #Delete this example and add some real ones
  it "renders 'hello' on acton index" do
    get :index
    response.body.should == 'hello'
  end

end
