require 'singleton'

module DMMCrawler
  class Agent
    include Singleton

    def agent
      agent = ::Mechanize.new
      agent.request_headers = { 'Accept-Encoding' => '' }
      agent.ignore_bad_chunking = true
      agent
    end
  end
end
