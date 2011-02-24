class Project < ActiveRecord::Base
  has_many :tickets
  belongs_to :user
  validates :name, :presence => true
end

