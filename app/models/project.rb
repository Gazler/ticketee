class Project < ActiveRecord::Base
  has_many :tickets
  belongs_to :user
  has_many :permissions, :as => :object
  validates :name, :presence => true

  scope :readable_by, lambda { |user|
    joins(:permissions).where(:permissions => { :action => "read", :user_id => user.id })
  }

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end

end

