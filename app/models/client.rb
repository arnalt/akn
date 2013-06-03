class Client < ActiveRecord::Base
  has_many :works ,  dependent: :restrict
  has_many :tasks

#  validates :name, :project,  uniqueness:true

  def self.get_client_id(client, project)
    where('name = ? and project = ?', client, project)
  end
end
