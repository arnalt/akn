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
      @client = FactoryGirl.create(:client)
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
      end
    end
    context "with invalid clientname" do
      it "redirects to the work" do

        client = Client.first
        post :output,  {:clientname => nil, :client =>  client.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param }
        response.should redirect_to works_path
      end
    end
    context "with invalid period" do
      it "redirects to the work" do

        client = Client.first
        post :output,  {:clientname =>client.name, :client =>  client.name, :period_begin => ''.to_param, :period_end => ''.to_param }
        response.should redirect_to works_path
      end
    end
  end
  describe "POST output_pdf" do
    before(:each) do
      Client.destroy_all
      User.destroy_all
      @user = FactoryGirl.create(:user)
      @client = FactoryGirl.create(:client)
      @task = FactoryGirl.create(:task, :client => @client)
      @work = Work.create( :client =>  @client, :user =>   @user, :task => @task, :date =>  '10.04.2013', :start_at =>  '8:00', :end_at => '16:00', :pause => '0')
      @format = 'pdf'
      request.cookies[:remember_token] = @user.remember_token
    end

    context "with valid params" do
      it "re_renders the output_view" do
        post :output_pdf,  {:clientname => @client.name,  :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param,
                :sending_email => '1'.to_param, :email => 'altenhofer@web.de'.to_param,:format => 'pdf'.to_param }

        assigns(:start_at).to_s.should eq '2013-04-01'
        assigns(:end_at).to_s.should eq '2013-04-30'
# You don't assign any varaibles email and sending_email in controller so you shouldn't check it below
#        assigns(:sending_email).to_s.should eq '1'
 #       assigns(:email).to_s.should eq 'altenhofer@web.de'
        assigns(:client_id).should_not be_nil
        assigns(:works).should_not be_nil
      end
    end

    context "with valid params" do
      it "redirects to works_path" do
        post :output_pdf,  {:clientname =>@client.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param, :sending_email => '1'.to_param, :email => 'altenhofer@web.de'.to_param,:format => 'pdf'.to_param }
        response.should redirect_to works_path
      end
    end

    context "with empty email" do
      it "redirects to the pdf_path" do
        post :output_pdf,  {:clientname => @client.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param, :sending_email => '1'.to_param, :email => ''.to_param, :format => 'pdf'.to_param }
        response.should redirect_to pdf_path
      end
    end

    context "with invalid email" do
      it "redirects to the pdf_path" do
        post :output_pdf,  {:clientname => @client.name, :period_begin => '01.04.2013'.to_param, :period_end => '30.04.2013'.to_param, :sending_email => '1'.to_param, :email => 'altenhofer@web'.to_param, :format => 'pdf'.to_param }
        response.should redirect_to pdf_path
      end
    end

    context "with invalid period for excel" do
      it "redirects to the works_path" do
        post :output_pdf,  {:clientname => @client.name, :period_begin => '01.04.2013'.to_param, :period_end => '15.05.2013'.to_param, :sending_email => '1'.to_param, :email => 'altenhofer@web.com'.to_param, :format => 'xls'.to_param }
        response.should redirect_to works_path
      end
    end
  end
end


