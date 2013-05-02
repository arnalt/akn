module ReportsHelper
  def chart_pdf
   Gchart.bar(:data => @bar_chart,
                                                 :title => 'Monthly working hours',
                                                 :bar_colors => '76A4FB',
                                                 :background => 'EEEEEE',
                                                 :chart_background => 'CCCCCC',
                                                 :legend => 'Monthly working days',
                                                 :axis_with_labels =>  'x',
                                                 :axis_labels => @xdata,
                                                 :size => '700x400')
  end

end
