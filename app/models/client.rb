class Client < ActiveRecord::Base
  has_many :works
  has_many :tasks

  validates :name, :project,  uniqueness:true

  def self.get_client_id(clientname)
    where('name = ?', clientname)
  end
end
