class Report
  include ActiveAttr::Model

  attribute :username
  attribute :clientname
  attribute :period_begin
  attribute :period_end
  attribute :passed


  validates :username, :clientname, :period_begin, :period_end, :passed, presence: true

  end