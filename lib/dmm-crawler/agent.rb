module DMMCrawler
  class Agent
    attr_accessor :agent

    def initialize
      @agent = ::Mechanize.new
      @agent.request_headers = { 'Accept-Encoding' => '' }
      @agent.ignore_bad_chunking = true
    end
  end
end
