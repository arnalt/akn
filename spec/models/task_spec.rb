require 'spec_helper'

describe Task  do
it "has a valid factory"   do
   FactoryGirl.create(:task).should be_valid
end

it "is invalid without a name"  do
   FactoryGirl.build(:task, name: nil).should_not be_valid
end
it "is valid without a description"  do
   FactoryGirl.build(:task, description: nil).should be_valid
end
it "does not allow duplicate names per task" do
   task1 = FactoryGirl.create(:task, :name => "Task#1000")
   task2 = FactoryGirl.build(:task, :name => "Task#1000").should_not be_valid
end
end
