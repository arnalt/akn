class Task < ActiveRecord::Base
  belongs_to :client
  has_many :works

  validates :name, presence: true
  validates :name,  uniqueness:true
end
