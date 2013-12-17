class Project < ActiveRecord::Base
  belongs_to :client
  has_many :works ,  dependent: :restrict
  has_many :tasks

  validates :name, presence: true
  validates :name,  uniqueness: true

  def self.get_project_id (projectname, client_id)
     where('name = ? and client_id = ?', projectname,client_id)
  end

end
