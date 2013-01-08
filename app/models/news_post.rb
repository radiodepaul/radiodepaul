class NewsPost < ActiveRecord::Base
  belongs_to :author, class_name: 'Person' 

  def snippet
    html.split[0..(30-1)].join(' ') + (html.split.size > 30 ? '...' : '')
  end 

  def html
    RDiscount.new(content, :smart, :filter_html).to_html.html_safe
  end

  #def as_json(options={})
   #{:id => self.id,
    #:headline => self.headline,
    #:snippet => snippet(RDiscount.new(self.content, :smart, :filter_html).to_html.html_safe , 30),
    #:content => RDiscount.new(self.content, :smart, :filter_html).to_html.html_safe,
    #:author => { :name => self.person.first_last_name },
    #:published_at => self.datetime_published.to_date.to_formatted_s(:long_ordinal) }
  #end

  def as_json(options={})
    options[:methods] ||= [:html, :snippet]

    super(options)
  end
end
