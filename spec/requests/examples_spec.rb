require "spec_helper"



describe WorksController do
  before(:each) do
    @user = User.create(:firstname => "Klaus", :lastname => "Mustermann", :email => "mustermann@example.com",
                                           :password => "foobar", :password_confirmation => "foobar")
    @work = mock(Work)
    @work.stub!(:user=)
    @work.stub!(:save).and_return(true)
     sign_in @user
  end

  describe "GET new" do
    context "given the user is signed in"
      it "initializes a new Work model" do
        Work.should_receive(:new)
        get :new, :user_id => @user_id
      end
    it "renders the new template"  do
      get :new, :user_id => @user.id
      response.should render_template("new")
    end
  end
end
