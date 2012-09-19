require "fileutils"

rootname = "D:/tmpdata/"
srcname = "syncsrc"
destname = "syncdst"

puts checkpath = rootname+srcname
puts updatepath = rootname+destname
#puts Dir.entries checkpath
=begin
(Dir.entries checkpath).each do |fileobj|
  print fileobj, " "
end

puts "\n---"
for fileobj in Dir.entries checkpath
  print fileobj, " "
end
=end

puts "\n---"
Dir.foreach(checkpath){|x|
  next if x == '.' or x =='..'
  fullsrcpath = checkpath + File::Separator + x
  fulldestpath = updatepath + File::Separator + x
  if File.exist?(fullsrcpath)
    if File.exist?(fulldestpath)
      print "file exist, check updatetime "
      #FileUtils.cp_r(fullsrcpath, fulldestpath)
    else
      FileUtils.copy_file(fullsrcpath, fulldestpath, preserve=true)
    end
    print x, " ", File.atime(fullsrcpath), " ", File.ctime(fullsrcpath), " ", File.mtime(fullsrcpath), " ", File.ftype(fullsrcpath), "\n"
  end
}

