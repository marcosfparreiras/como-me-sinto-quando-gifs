# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'restclient'

# page = Nokogiri::HTML(RestClient.get("http://en.wikipedia.org/"))
page = Nokogiri::HTML(RestClient.get("http://comoeumesintoquando.tumblr.com/"))
puts page.class   # => Nokogiri::HTML::Document

content = page.css('div.post-content')
content.each do |c|
  puts c.css('h3 a').text
  p c.css('p img').name
end

# p content.css('h3 a').text
# p content.css('p img')

