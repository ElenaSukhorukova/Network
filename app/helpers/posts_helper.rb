# frozen_string_literal: true

module PostsHelper
  def anchor(post)
    dom_id(post.comments.order_desc.first)
  end
end
