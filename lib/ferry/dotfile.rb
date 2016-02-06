dotfile = Pathname.new(File.join(Dir.home, '.ferryfile'))
load dotfile if dotfile.file?
