# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'restclient'

# page = Nokogiri::HTML(RestClient.get("http://en.wikipedia.org/"))
page = Nokogiri::HTML(RestClient.get("http://comoeumesintoquando.tumblr.com/"))
# puts page.class   # => Nokogiri::HTML::Document

posts = page.css('div.post.post-type-text')
posts.each do |post|
  a_tag = post.css('div.post-content h3 a')
  img_tag = post.css('div.post-content p img') #|| post.css('div.post-content figure img')
  if(img_tag.empty?)
    puts 'buscou de novo'
    img_tag = post.css('div.post-content figure img')
  end
  if(img_tag.empty?)
    puts 'buscou de novo outra vez'
    img_tag = post.css('div.post-content img')
  end

  puts a_tag.text
  puts img_tag[0]['src']
  # p a_tag
  # p img_tag

  # puts a_tag.class
  # puts img_tag.class

  puts "\n----------------------\n"
end

# p content.css('h3 a').text
# p content.css('p img')

