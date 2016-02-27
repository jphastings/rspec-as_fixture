describe RSpec::AsFixture do
  context 'when included in an RSpec suite' do
    include described_class

    context 'when a context is loaded as a fixture', :as_fixture do
      it 'should load the fixture file with the base describe block\'s name' do
        expect(fixture_loaded).to eq true
      end

      context 'when a sub-context also loads a fixture', :as_fixture do
        it 'should load the original context fixtures' do
          expect(fixture_loaded).to eq true
        end

        it 'should load the sub-context fixtures' do
          expect(sub_fixture_loaded).to eq true
        end

        it 'should override the original fixture with the sub fixture' do
          expect(level).to eq 'sub'
        end
      end
    end
  end
end
