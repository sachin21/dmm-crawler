# frozen_string_literal: true

module DMMCrawler
  module Ranking
    class BaseRanking
      def arts
        raise NotImplementedError
      end

      private

      def page
        @agent.get(@url)
      end

      def sleep_each
        sleep rand(0.7..1.3)
        yield
      end

      def discriminate_agent(agent)
        return agent if agent.is_a?(Mechanize)
        raise TypeError
      end
    end
  end
end
