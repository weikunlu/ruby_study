
require 'open-uri'
require 'cgi'
require 'rubygems'

# gem install nokogiri
require 'nokogiri'

=begin
requirement:
這是 amazon 底下 Electronics 的分類。我要抓左邊department底下所有分類、子分類的英文名稱與超連結網址。
輸出例如可用csv，子分類就右移一個欄位，網址放最右邊即可。

〔額外〕
search那邊還有其他分類類別可以選，選後按下go就會出現各自的子類別。除了all之外，其他類別我也想要抓。

〔進階〕
如果你有辦法連商品頁內容都一併抓下

=end

homeuri = 'http://www.amazon.com/ref=nb_sb_noss_null'
doc = Nokogiri::HTML(open(homeuri))
doc.css('script, link').each { |node| node.remove }
html = doc.to_s

#find all conditions
html.scan(/<option value="search-alias=(.*)">/) do |department|
  puts 'department: %s' % department 
  
  #associate condition and search
  department = URI.escape('search-alias='+department[0])
  uri = 'http://www.amazon.com/s/ref=nb_sb_noss/178-4301596-5979835?url=%s&field-keywords=' % department
  doc = Nokogiri::HTML(open(uri))
  doc.css('script, link').each { |node| node.remove }
  html = doc.to_s
  
  html.scan(/<h2>Department<\/h2>(\s)<ul[^<]*>([^<]*+(?:(?!<\/?+ul)<[^<]*+)*+)<\/ul>/) do |eachpart| 
    
    phtml = eachpart[1]
    
    print "title:"
    puts phtml.scan(/<strong>([\w\s]*)<\/strong>/)
    
    phtml.scan(/<a href="(.*)">/) do |link|
      puts CGI.unescapeHTML(link[0])
    end
    
    phtml.scan(/<span class="refinementLink">(.*)<\/span>/) do |name|
      name[0].gsub!(/<\/?[^>]+>/, '')
      puts CGI.unescapeHTML(name[0])
    end
  end

end
