module PostsHelper
  def anchor(post)
    dom_id(post.comments.order_desc.first)
  end
end
