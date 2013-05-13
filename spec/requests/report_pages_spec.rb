require 'spec_helper'

describe "Works pages" do

  subject { page }

  def valid_attributes
    {}
  end

  describe "input" do
   before do
        visit input_path
    end

    it { should have_selector('title', text: 'Input Reports') }
  end

  describe "excel" do
    before do
      visit excel_path
    end

   it { should have_selector('title', text:'Excel Reports') }
  end

  describe "output" do
    before do
     # user = FactoryGirl.create(:user)
     # client = FactoryGirl.create(:client)
     # task = FactoryGirl.create(:task, :client => client)
    #  work = FactoryGirl.create(:work, :task => task, :user => user)

     user = User.first
     client = Client.first

      sign_in user
      visit input_path
      fill_in "Client",            with: client.name
      fill_in "Start_at",         with: Work.start_at
      fill_in "End_at",            with: Work.work.end_at
      click_button "GO"




    #  visit output_path({:id => work.id, :clientname => client.name, :period_begin => '01.04.2013', :period_end => '30.04.2013'})
    end

   it { should have_selector('title', text:'Output Reports') }

  end

  end