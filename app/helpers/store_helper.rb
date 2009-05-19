module StoreHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style" ] = "display: none"
    end
    content_tag("div" , attributes, &block)
  end
  
  # Override entry style to hide bottom border for last item in the list
  def noborder_div_if(condition, attributes = {}, &block)
    attributes["id" ] = "entry"
    if condition
      attributes["style" ] = "border-bottom: 0px"
    end
    content_tag("div" , attributes, &block)
  end
end
