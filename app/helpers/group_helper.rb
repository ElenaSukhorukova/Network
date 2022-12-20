module GroupHelper
  def group_page_name(page_name = '')
    render partial: 'navigation', locals: { page_name: page_name }
  end

  def link_nav(title, url, options = {})
    page_name = options.delete :page_name
    css_text = page_name == title ? "btn btn-dark my-2 btn-sm" : "btn btn-outline-dark my-2 btn-sm"
    options[:class] = options[:class] ? (options[:class] + ' ' + css_text) : 
                                        css_text
    
    link_to title, url, options
  end
end
