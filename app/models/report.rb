class Report
  include ActiveAttr::Model

  attribute :username
  attribute :projectname
  attribute :period_begin
  attribute :period_end
  attribute :passed


  validates :username, :projectname, :period_begin, :period_end, :passed, presence: true

  end