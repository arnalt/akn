class Task < ActiveRecord::Base
  belongs_to :client
  has_many :works

  validates :name,  uniqueness:true
end
