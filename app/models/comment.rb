class Comment < ApplicationRecord
  belongs_to :task
  validates_presence_of :text

  mount_uploader :file, ImageUploader
end
