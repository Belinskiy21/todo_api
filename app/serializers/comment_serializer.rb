class CommentSerializer <ApplicationSerializer
  attributes :id, :text, :file, :created_at, :updated_at

  belongs_to :task
end
