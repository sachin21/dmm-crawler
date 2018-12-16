describe DMMCrawler::Ranking::AdultGameRanking do
  let(:agent) { DMMCrawler::Agent.instance.agent }
  let(:arguments) { { agent: agent, term: term } }

  describe '#arts' do
    subject { attachments }

    after { sleep 2 }

    context 'with length' do
      let(:term) { 'weekly' }
      let(:attachments) { described_class.new(arguments).arts.length }

      it { is_expected.to be 20 }
    end

    context 'with weekly argument' do
      let(:term) { 'weekly' }
      let(:attachments) { described_class.new(arguments).arts }

      it { is_expected.to all(include(:title, :title_link, :main_image_url, :sample_image_urls, :submedia, :author, :rank, :affiliateable, :tags)) }
      it { is_expected.to all(satisfy { |art| art.all? { |_k, v| v != '' && v != nil} }) }
    end

    context 'with not registered argument' do
      let(:agent) { nil }
      let(:term) { 'weekly' }
      let(:attachments) { -> { described_class.new(arguments).arts } }

      it { is_expected.to raise_error(TypeError) }
    end
  end
end
