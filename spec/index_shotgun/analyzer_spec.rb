describe IndexShotgun::Analyzer do
  describe "#table_indexes" do
    subject(:table_indexes) { IndexShotgun::Analyzer.table_indexes(table) }

    context "When exists indexes" do
      let(:table) { "user_stocks" }

      its(:count) { should eq 3 }

      describe "index_user_stocks_on_user_id_and_article_id_and_already_read" do
        subject { table_indexes.find { |index| index.name == index_name } }

        let(:index_name) { "index_user_stocks_on_user_id_and_article_id_and_already_read" }

        its(:name)    { should eq index_name }
        its(:unique)  { should be false }
        its(:columns) { should eq %w(user_id article_id already_read) }
      end

      describe "index_user_stocks_on_user_id_and_article_id" do
        subject { table_indexes.find { |index| index.name == index_name } }

        let(:index_name) { "index_user_stocks_on_user_id_and_article_id" }

        its(:name)    { should eq index_name }
        its(:unique)  { should be true }
        its(:columns) { should eq %w(user_id article_id) }
      end

      describe "index_user_stocks_on_user_id" do
        subject { table_indexes.find { |index| index.name == index_name } }

        let(:index_name) { "index_user_stocks_on_user_id" }

        its(:name)    { should eq index_name }
        its(:unique)  { should be false }
        its(:columns) { should eq ["user_id"] }
      end
    end

    context "When not exists indexes" do
      let(:table) { "users" }

      its(:count) { should eq 0 }
    end
  end

  describe "#check_indexes" do
    subject(:check_indexes) { IndexShotgun::Analyzer.check_indexes(table).map { |row| row[:result] } }

    context "When exists duplicate indexes" do
      let(:table) { "user_stocks" }

      its(:count) { should eq 3 }

      # rubocop:disable Metrics/LineLength
      it { should include "index_user_stocks_on_user_id is a left-prefix of index_user_stocks_on_user_id_and_article_id" }
      it { should include "index_user_stocks_on_user_id is a left-prefix of index_user_stocks_on_user_id_and_article_id_and_already_read" }
      it { should include "index_user_stocks_on_user_id_and_article_id_and_already_read has column(s) on the right side of unique index (index_user_stocks_on_user_id_and_article_id). You can drop if low cardinality" }
      # rubocop:enable Metrics/LineLength
    end

    context "When not exists duplicate indexes" do
      let(:table) { "comments" }

      its(:count) { should eq 0 }
    end
  end

  describe "#perform" do
    subject { IndexShotgun::Analyzer.perform }

    its(:message) { should include "# Total Duplicate Indexes  3" }
    its(:message) { should include "# Total Indexes            5" }
    its(:message) { should include "# Total Tables             4" }
    its(:duplicate_index_count) { should eq 3 }
    its(:total_index_count)     { should eq 5 }
    its(:total_table_count)     { should eq 4 }
  end
end
