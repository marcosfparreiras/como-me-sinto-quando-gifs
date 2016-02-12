require 'nokogiri'
require 'open-uri'
require 'restclient'

class ComoMeSintoQuando

  def initialize(page_number = 1)
    page_limit = 1450
    if(page_number <= 0)
      @page_number = 1
    elsif(page_number > page_limit)
      @page_number = page_limit
    else
      @page_number = page_number
    end
  end

  def url
    "http://comoeumesintoquando.tumblr.com/page/#{@page_number}"
  end

  def get_dom_elements
    Nokogiri::HTML(RestClient.get(url))
  end

  def get_gif(post)
    {
      :text => get_gif_title(post),
      :img =>get_gif_url(post)
    }
  end

  def get_gif_title(post)
    post.css('div.post-content h3 a').text
  end

  def get_gif_url(post)
    img_tag = post.css('div.post-content p img') #|| post.css('div.post-content figure img')
    if(img_tag.empty?)
      img_tag = post.css('div.post-content figure img')
    end
    if(img_tag.empty?)
      img_tag = post.css('div.post-content img')
    end
    img_tag[0]['src']
  end

  def run
    page = get_dom_elements
    gifs = []

    posts = page.css('div.post.post-type-text')
    posts.each do |post|
      gifs << get_gif(post)
    end
    gifs
  end

end



example = ComoMeSintoQuando.new(2)

gifs =  example.run
gifs.each do |key, value|
  puts "#{key}  ->  #{value}"
end
puts 'ok'

