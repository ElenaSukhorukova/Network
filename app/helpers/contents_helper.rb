module ContentsHelper
  def anchor(content)
    dom_id(content.comments.order_desc.first)
  end
end
