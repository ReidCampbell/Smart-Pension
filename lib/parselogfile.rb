class ParseLogFile
  attr_reader :log_file

  def initialize(file_path)
    if file_path == nil
      puts 'Missing file path!'
      return
    end

    @file = File.open(file_path, 'r')
    @log_file = Hash.new { |h, k| h[k] = [] }

    parse_file(@file)
  end

  def parse_file(file_path)
    file_path.each do |line|
      site_address, ip_address = line.split(' ')
      @log_file[site_address] << ip_address
    end
    process(@log_file)
  end

  private

  def process(result)
    visits = {}
    unique_visits = {}
  
    result.each do |site, ip|
      visits[site] = ip.length
      unique_visits[site] = ip.uniq.length
    end
  
    print_results('Website Visits in Decending Order', visits)
    print_results('Unique Website Visits in Decending Order', unique_visits)
  end
  
def print_results(header, result)
  puts '-------------------------------------------------'
  puts header.center(50)
  puts '-------------------------------------------------'
  sorted_results = result.sort_by { |site, count| -count }
  sorted_results.each { |site, count| puts "| #{site.center(15)} | #{count.to_s.center(27)}" }
  puts '-------------------------------------------------'
  end
end

log_file = ParseLogFile.new(ARGV[0])


