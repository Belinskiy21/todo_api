class ProjectSerializer < ApplicationSerializer
  attributes :id, :title, :created_by

  has_many :tasks, dependent: :destroy
end
