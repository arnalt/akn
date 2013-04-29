require 'spec_helper'

describe "Works pages" do

  subject { page }

  def valid_attributes
       {}
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit works_path
    end

    it { should have_selector('title', text: 'Works') }
  end

  describe "new" do
    let(:user) { FactoryGirl.create(:user) }
    let(:work) { FactoryGirl.create(:work) }
    before do
      sign_in user
      visit new_work_path
    end

    it { should have_selector('title', text: 'New Works') }
  end

  describe "show" do
    before do
      user = FactoryGirl.create(:user)
      client = FactoryGirl.create(:client)
      task = FactoryGirl.create(:task, :client => client)
      work = FactoryGirl.create(:work, :task => task)


      sign_in user
      visit work_path(work)
    end

    it { should have_selector('title', text: 'Works') }
  end


  describe "edit" do
    before do
      user = FactoryGirl.create(:user)
      client = FactoryGirl.create(:client)
      task = FactoryGirl.create(:task, :client => client)
      work = FactoryGirl.create(:work, :task => task, :user => user)


      sign_in user
      visit edit_work_path(work, { 'id' => work.id})
    end

    it { should have_selector('title', text: 'Works') }
  end
end
