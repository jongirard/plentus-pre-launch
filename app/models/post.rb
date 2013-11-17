class Post < ActiveRecord::Base
  
def to_param 
  [id, self.name.parameterize].join("-")
end
  
def self.update_from_feed
  
    feed_url = ENV['FEED_URL']
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    
end

  private
  
  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? :guid => entry.id
      create!(guid: entry.id, name: entry.title, author: entry.author, summary: entry.summary, published_at: entry.published)
      flash[:notice] = "Feeds Imported"
    end
  end
end
end




