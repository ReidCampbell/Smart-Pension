class ParseLogFile
  attr_reader :log_file

  def initialize(file_path = nil)
    @log_file = {}
    parse_file(file_path)
  end

  def parse_file(file_path)
    return 'Attach log file to parse data' if logfile_path.nil?
    return 'Given file does not exist' unless valid_file?(logfile_path)
    File.open(file_path,'r').each { |line| process_line(line) }
    process_result(@log_file)
  end

  def split_line(line)
    site_address, ip_address = line.split(' ')

    unless @log_file[site_address]
      @log_file[site_address] = []
    end

    @log_file[site_address].push(ip_address)
  end

  def process_result(result)
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
