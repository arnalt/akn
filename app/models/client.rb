class Client < ActiveRecord::Base
  has_many :works
  has_many :task
end
