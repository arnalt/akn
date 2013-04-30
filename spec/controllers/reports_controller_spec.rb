require 'spec_helper'

describe ReportsController do

  def valid_attributes

  end


  def valid_session
    {}
  end


  describe "POST output" do
    context "with valid attributes" do

      it "re-renders the output view" do
        user = FactoryGirl.create(:user)
        client = FactoryGirl.create(:client)
        task = FactoryGirl.create(:task, :client => client)
        work = FactoryGirl.create(:work, :client => client, :task => task, :user => user)

        post :output,  { :clientname => client.name, :period_begin => '01.04.2013', :period_end => '30.04.2013', :client_id => client.id}
        response.should render_template 'output.html.erb'
      end
    end
  end
end


