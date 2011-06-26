class Resource < ActiveRecord::Base
  
  validates_presence_of :title, :summary, :submitted_by
  validates_uniqueness_of :title
  validates_format_of :submitted_by,
   :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
 
  validation_group :step1, :fields=>[:all]

  named_scope :reviewed, :conditions => {:status => 'reviewed'}, :order => :title
  
end
