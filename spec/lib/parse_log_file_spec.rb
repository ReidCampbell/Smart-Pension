require './lib/parselogfile'

describe "ParseLogFile", :parseLogFile do

  describe "output" do
    before(:all) do
      mock_stream = StringIO.new
      original_output = $stdout
      $stdout = mock_stream

      ParseLogFile.new('./spec/mock.log')
      @result = $stdout.string.split(/\n/)
      $stdout = original_output
    end

    it "should print duration warning" do
      expect(@result).to include("Processing file. It may take a while.")
      expect(@result).to include("Processing finished!")
    end

    it "should print Visists" do
      visits_index = @result.find_index('Visits')
      expect(visits_index).not_to be(nil)
      expect(@result[visits_index + 1]).to match('help 3')
      expect(@result[visits_index + 2]).to match('test 2')
    end

    it "should print Unique visists" do
      unique_visits_index = @result.find_index('Unique visits')
      expect(unique_visits_index).not_to be(nil)
      expect(@result[unique_visits_index + 1]).to match('test 2')
      expect(@result[unique_visits_index + 2]).to match('help 1')
    end
  end
end