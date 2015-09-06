using IndexShotgun::ArrayStartWith

describe IndexShotgun::ArrayStartWith do
  let(:source) { ["column1", "column2", "column3"] }

  describe "#start_with?" do
    subject { source.start_with?(target) }

    context "When exactly match" do
      let(:target) { ["column1", "column2", "column3"] }

      it { should be true }
    end

    context "When left match" do
      let(:target) { ["column1", "column2"] }

      it { should be true }
    end

    context "When not left match" do
      let(:target) { ["column1", "column3"] }

      it { should be false }
    end
  end
end
