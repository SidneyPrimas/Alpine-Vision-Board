class Task < ActiveRecord::Base
  attr_accessible :task
  #Don't know exactly how this works, but returns if statement necessary. See update control
  validates :task, presence: true
  
end
