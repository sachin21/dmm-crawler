module DMMCrawler
  class Client
    attr_accessor :agent

    def initialize
      @agent = Agent.instance.agent

      yield @agent if block_given?
    end

    def rankings(arguments)
      Ranking.new(arguments.merge!(agent: @agent)).arts
    end
  end
end
