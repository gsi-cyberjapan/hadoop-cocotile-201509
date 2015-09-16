require 'json'
require 'fileutils'

count = 0
File.foreach('part-00000') {|l|
  r = JSON.parse(l)
  target = r['path'] + '.csv'
  target_dir = File.dirname(target)
  FileUtils.mkdir_p(target_dir) unless File.directory?(target_dir)
  File.open(target, 'w') {|w|
    w.print(r['payload'] + "\n")
  }
  count += 1
  print "#{Time.now}: wrote #{target}.\n" if count % 10000 == 0
}
