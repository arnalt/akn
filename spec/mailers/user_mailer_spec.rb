require "spec_helper"

describe UserMailer do
  describe "report_email" do
    let(:works)   { Work.all }
    let(:recipient) { "altenhofer@web.de" }
    let(:xdata) { ['01', '02', '03', '04', '05']}
    let(:bar_chart) { [8.0, 7.0, 9.0, 8.0, 8.0]}
    let(:w_avg)    {8}
    let(:w_days)  {5}
    let(:w_max)   {9}
    let(:w_min)    {7}
    let(:format)   { 'pdf'}
    let(:email) { UserMailer.report_email(recipient, works, xdata,bar_chart,w_avg, w_days,w_max, w_min, format ) }

    it { email.from.should == [ "reports@example.com" ] }
    it { email.to.should == [ recipient ] }
    it { email.subject.should == "Monthly report" }
  end
end
