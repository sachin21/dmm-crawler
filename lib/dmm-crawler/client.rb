# frozen_string_literal: true

module DMMCrawler
  class Client
    attr_accessor :agent

    def initialize
      @agent = Agent.instance.agent

      yield @agent if block_given?
    end

    def rankings(arguments)
      Ranking::DojinRanking.new(arguments.merge!(agent: @agent)).arts
    end

    def adult_game_rankings(arguments)
      Ranking::AdultGameRanking.new(arguments.merge!(agent: @agent)).arts
    end

    def get_attributes(url)
      Attributes::DojinAttributes.new(url, agent: @agent).to_a
    end

    def affiliateable?(url)
      Attributes::DojinAttributes.new(url, agent: @agent).affiliateable?
    end
  end
end
