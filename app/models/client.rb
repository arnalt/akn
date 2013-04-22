class Client < ActiveRecord::Base
  has_many :works
  has_many :tasks

  validates :name, :project,  uniqueness:true
end
