class NewsPost < ActiveRecord::Base
  belongs_to :author, class_name: 'Person'

  def snippet
    html.split[0..(30-1)].join(' ') + (html.split.size > 30 ? '...' : '')
  end

  def html
    RDiscount.new(content, :smart, :filter_html).to_html.html_safe
  end
end
