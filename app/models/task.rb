class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  validates_presence_of :title
end
