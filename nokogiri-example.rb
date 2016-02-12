require 'nokogiri'
require 'open-uri'
require 'restclient'

page = Nokogiri::HTML(RestClient.get("http://comoeumesintoquando.tumblr.com/"))

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

  puts a_tag.text
  puts img_tag[0]['src']

  puts "\n"
end
