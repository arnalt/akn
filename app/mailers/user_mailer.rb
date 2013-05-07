class UserMailer < ActionMailer::Base
  default from: "reports@example.com"

   def  report_email(user, works, xdata, bar_chart, w_avg, w_days, w_max, w_min)
       @works = works
       @xdata = xdata
       @bar_chart = bar_chart
       @w_avg = w_avg
       @w_days = w_days
       @w_max = w_max
       @w_min = w_min
        mail( :to => user.email,
                  :subject => 'Monthly report') do |format|
          format.html { render 'reports/output',  :layout => false }
        end
   end
  end
