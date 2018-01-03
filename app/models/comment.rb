class Comment < ApplicationRecord
  belongs_to :task
  validates_presence_of :text
  validates_presence_of :file
end
