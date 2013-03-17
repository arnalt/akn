class Work < ActiveRecord::Base
  belongs_to :user

  before_create :complete_work
  before_update :complete_work



  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end




  def complete_work
    @arr = I18n.t("date.day_names")
    self.tag = @arr.at(self.datum.wday)
    self.kw = ((self.datum - self.datum.at_beginning_of_year) / 7 + 0.8).round.to_i
    self.std = ((((self.bis.hour * 60) + self.bis.min) - ((self.von.hour * 60) + self.von.min)) - ((self.mm.hour * 60) + self.mm.min)) / 60.0
  end

end
