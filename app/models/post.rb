class Post < ActiveRecord::Base
  
  before_create :create_slug
  
def to_param 
  slug
end

def create_slug
  self.slug = self.name.parameterize
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
    end
  end

end
end




