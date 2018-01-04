class TaskSerializer < ApplicationSerializer
  attributes :id, :title, :deadline, :done

  belongs_to :project
  has_many :comments, dependent: :destroy
end
