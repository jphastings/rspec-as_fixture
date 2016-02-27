require_relative '../boogie'

describe Boogie do
  describe '#accuse?' do
    subject { described_class.new(blame).accuse? }

    context 'when I\'m blaming the sunshine', :as_fixture do
      it { expect(subject).to eq false }
    end

    context 'when I\'m blaming the moonlight', :as_fixture do
      it { expect(subject).to eq false }
    end

    context 'when I\'m blaming the good times', :as_fixture do
      it { expect(subject).to eq false }
    end

    context 'when I\'m blaming the boogie', :as_fixture do
      it { expect(subject).to eq true }
    end
  end
end