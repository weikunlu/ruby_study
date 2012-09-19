require 'open-uri'

open('cat.jpg', 'wb') do |file| 
  file << open('http://static.tumblr.com/6t3upxl/Aawm08w0l/khout-kitten-458882.jpeg').read 
end 

