require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    @task = FactoryGirl.create(:task)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/@task.name/)
    rendered.should match(/@task.description/)
  end
end
