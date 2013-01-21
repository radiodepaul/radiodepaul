module ApplicationHelper
  def markdown(text, options = {})
    #default = { hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true }
    #options = default.merge(options)

    #renderer = Redcarpet::Render::XHTML.new(options)

    #Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    RDiscount.new(text).to_html
  end
end
