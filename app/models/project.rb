class Project < ApplicationRecord
  # belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  validates_presence_of :title, :created_by
end
