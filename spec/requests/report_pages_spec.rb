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


  end