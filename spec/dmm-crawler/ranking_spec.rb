describe DMMCrawler::Ranking do
  let(:agent) { DMMCrawler::Agent.instance.agent }
  let(:submedia) { 'cg' }
  let(:arguments) { { submedia: submedia, term: term, agent: agent } }

  describe '#arts' do
    subject { attachments }

    after { sleep 2 }

    context 'with length' do
      let(:attachments) { described_class.new(arguments).arts.length }
      let(:term) { '24' }

      it { is_expected.to be 10 }
    end

    context 'with 24 argument' do
      let(:attachments) { described_class.new(arguments).arts }
      let(:term) { '24' }

      it { is_expected.to all(include(:title, :title_link, :image_url, :submedia, :author, :informations, :rank, :price, :affiliateable, :tags)) }
      it { is_expected.to all(satisfy { |art| art.all? { |_k, v| v != '' } }) }
    end

    context 'with not registered argument' do
      let(:attachments) { -> { described_class.new(arguments).arts } }
      let(:term) { nil }

      it { is_expected.to raise_error(TypeError) }
    end
  end
end
