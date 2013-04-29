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
        client = FactoryGirl.create(:client )

        post :output
        response.should render_template 'output.html.erb'
      end
    end
  end
end


