class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates_presence_of :title
  acts_as_list scope: :project


  def self.change(task, val)
    task.send(val)
  end
end
