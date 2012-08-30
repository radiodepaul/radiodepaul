class NewsPost < ActiveRecord::Base
	belongs_to :user 

	def snippet(thought, wordcount)
		thought.split[0..(wordcount-1)].join(" ") +(thought.split.size > wordcount ? "..." : "")
	end 

	def as_json(options={})
       {:id => self.id,
        :headline => self.headline,
        :snippet => snippet(RDiscount.new(self.content, :smart, :filter_html).to_html.html_safe , 30),
        :content => RDiscount.new(self.content, :smart, :filter_html).to_html.html_safe,
#        :author => { :name => self.user.first_last_name },
        :published_at => self.datetime_published.to_date.to_formatted_s(:long_ordinal)
    	}
   end
end
