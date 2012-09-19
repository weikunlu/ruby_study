
filepath = "D:/tmpdata/test.txt"
content = File.read(filepath)
print content
puts "\n--"

file = open(filepath, "r")
while line = file.gets
  print line
end
file.close


open(filepath, "r") do |file|
  file.each do |line|
    print line
  end  
end

outputfilepath = "D:/tmpdata/test(2).txt"
open(filepath, "rb") do |rfile|
  open(outputfilepath, "wb") do |wfile|
    rfile.each_byte do |byte|
      wfile.print([byte].pack("c*"))
    end
  end
end



puts $: