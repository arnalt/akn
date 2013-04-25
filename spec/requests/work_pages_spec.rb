require 'spec_helper'

describe "Works pages" do

  subject { page }

  describe "index" do
    let(:user)    { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit works_path
    end

      it { should have_selector('title', text: 'Works') }
  end

  describe "new" do
    let(:user)    { FactoryGirl.create(:user) }
    let(:work)   {FactoryGirl.create(:work)}
    before do
      sign_in user
      visit new_work_path
    end

      it { should have_selector('title', text: 'New Works') }
  end

  describe "show" do
    let(:user)    { FactoryGirl.create(:user) }
    let(:client)  { FactoryGirl.create(:client) }
    let(:task)     { FactoryGirl.create(:task) }
    let(:work)   { FactoryGirl.create(:work) }
    before do
      sign_in user
      visit work_path(work)
    end

    it { should have_selector('title', text: 'Works') }
  end

  describe "edit" do
    let(:user)    { FactoryGirl.create(:user) }
    let(:client)  { FactoryGirl.create(:client) }
    let(:task)    {FactoryGirl.create(:task)}
    let(:work)   { FactoryGirl.create(:work) }
    before do
      sign_in user
      visit edit_work_path(work)
    end

    it { should have_selector('title', text: 'Works') }
  end
end