class TaskSerializer < ApplicationSerializer
  attributes :id, :title, :deadline, :done, :position, :created_at, :updated_at

  belongs_to :project
  has_many :comments
end
