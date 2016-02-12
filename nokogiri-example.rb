require 'nokogiri'
require 'open-uri'
require 'restclient'

class ComoMeSintoQuando

  def initialize(page_number = 1)
    @page_number = page_number
  end

  def url
    "http://comoeumesintoquando.tumblr.com/#{@page_number}"
  end

  def get_dom_elements
    Nokogiri::HTML(RestClient.get(url))
  end

  def run
    page = get_dom_elements
    gifs = []

    posts = page.css('div.post.post-type-text')
    posts.each do |post|
      a_tag = post.css('div.post-content h3 a')
      img_tag = post.css('div.post-content p img') #|| post.css('div.post-content figure img')
      if(img_tag.empty?)
        img_tag = post.css('div.post-content figure img')
      end
      if(img_tag.empty?)
        img_tag = post.css('div.post-content img')
      end

      gif = Hash.new
      gif[:text] = a_tag.text
      gif[:img] = img_tag[0]['src']

      gifs << gif

      # puts a_tag.text
      # puts img_tag[0]['src']
      # puts "\n"
    end

    gifs

  end
  # last_page = 1450
  # page = Nokogiri::HTML(RestClient.get("http://comoeumesintoquando.tumblr.com"))

  # posts = page.css('div.post.post-type-text')
  # posts.each do |post|
  #   a_tag = post.css('div.post-content h3 a')
  #   img_tag = post.css('div.post-content p img') #|| post.css('div.post-content figure img')
  #   if(img_tag.empty?)
  #     img_tag = post.css('div.post-content figure img')
  #   end
  #   if(img_tag.empty?)
  #     img_tag = post.css('div.post-content img')
  #   end

  #   puts a_tag.text
  #   puts img_tag[0]['src']

  #   puts "\n"
  # end
end

example = ComoMeSintoQuando.new(0)

gifs =  example.run
gifs.each do |key, value|
  puts "#{key}  ->  #{value}"
end
puts 'ok'

