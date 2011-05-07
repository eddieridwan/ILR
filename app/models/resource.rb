class Resource < ActiveRecord::Base
  validates_presence_of :title, :summary
  validates_uniqueness_of :title
end
