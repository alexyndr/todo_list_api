class ErrorSerializer
  include FastJsonapi::ErrorSerializer
  set_id :id # defaults to :id, set to false to disable, can take a block
  link(:about) {|object| "http://todo_list/errors/#{object.type}"}
  status :status # defaults to :status, set to false to disable, can take a block
  code :code # defaults to :code, set to false to disable, can take a block
  title :title #defaults to :title, set to false to disable, can take a block
  detail :detail # defaults to :detail, set to false to disable, can take a block
  source_method :source # defaults to :source, set to false to disable, can take block, expected to be a hash
end