class Resource < ActiveRecord::Base
  
  validates_presence_of :title, :summary, :submitted_by
  validates_uniqueness_of :title
  validates_format_of :submitted_by,
   :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
 
  validation_group :step1, :fields=>[:all]

  named_scope :reviewed, :conditions => {:status => 'reviewed'}, :order => :title
  
# http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Resource.model_name
      end
    end
    super
  end

  def self.child_classes
    subclasses.map{ |c| c.to_s }.sort
  end


# http://coderrr.wordpress.com/2008/04/22/building-the-right-class-with-sti-in-rails/
  class << self
    def new_with_cast(*a, &b)
      if (h = a.first).is_a? Hash and (type = h[:type] || h['type']) and (klass = type.constantize) != self
        raise "wtF hax!!"  unless klass < self  # klass should be a descendant of us
        return klass.new(*a, &b)
      end   
      new_without_cast(*a, &b)
    end
    alias_method_chain :new, :cast
  end

end
