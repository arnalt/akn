class Task < ActiveRecord::Base
  belongs_to :client
  has_many :works, dependent: :restrict

  validates :name, presence: true
  validates :name,  uniqueness: true
end
