class Task < ActiveRecord::Base
  belongs_to :project
  has_many :works, dependent: :restrict

  validates :name, presence: true

end
