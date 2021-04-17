class LogParser
 
  def print_popular
    arr_new = sort_desc 'count'
    arr_new.each do |ele|
      puts "#{ele[0]} #{ele[1]['count']} visits"
    end
  end

  def print_unique
    arr_new = sort_desc 'unique'
    arr_new.each do |ele|
      puts "#{ele[0]} #{ele[1]['unique']} unique visits"
    end
  end

  def initialize(filename)
    @filename = filename
    @arr = readfile(filename)
    @hsh = memonize
  end

  private

  def readfile filename
    raise NofileFound.new filename unless File.exists?(filename)
    f = File.read(filename).chomp
    f.split("\n")
  end

  def memonize
    hsh = {} 
    @arr.each do |x|
      y = x.split(' ')
      z = y[0]
      w = y[1]

      if hsh.key?(y[0])
        hsh[z]['count']+=1
        unless hsh[z]['ips'].include?(w)
          hsh[z]['ips'].push(w)
          hsh[z]['unique']+=1
        end
      else
        hsh[z] ={} 
        hsh[z]['count'] = 1
        hsh[z]['ips']= [w]
        hsh[z]['unique'] = 1
      end
    end
    hsh
  end

  def sort_desc field
    @hsh.sort_by{ |k,v| -v[field] }
  end
end

class NofileFound < StandardError
  def initialize(filename)
    msg = "No such file exists: #{filename}"
    super(msg)
  end
end

