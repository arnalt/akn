require 'spec_helper'

describe ReportsController do

  def valid_attributes

  end

  def valid_session
    {}
  end

  describe "POST output" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      request.cookies[:remember_token] = @user.remember_token
    end
    context "with valid attributes" do
      it "re-renders the output view" do
        client = Client.first

        post :output,  {:clientname => client.name, :client =>  client.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param }

        assigns(:start_at).to_s.should eq '2013-04-01'
        assigns(:end_at).to_s.should eq '2013-04-30'
        assigns(:client_id).should_not be_nil
        assigns(:works).should_not be_nil
#        response.should render_template("output")
      end
    end
  end
end


