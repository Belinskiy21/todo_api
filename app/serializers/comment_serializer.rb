class CommentSerializer <ApplicationSerializer
  attributes :id, :text, :file

  belongs_to :task
end
