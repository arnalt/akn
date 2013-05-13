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
        client = Client.first
        post :output,  {:clientname => client.to_param, :client =>  Client.first.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param }
        response.should render_template("output")
      end
    end
  end
end


