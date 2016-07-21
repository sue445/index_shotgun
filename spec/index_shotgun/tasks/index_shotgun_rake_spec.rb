describe :index_shotgun do
  include_context :rake_task

  describe :fire do
    subject { rake["index_shotgun:fire"].invoke }

    let(:response) do
      response = IndexShotgun::Analyzer::Response.new
      response.message = message
      response
    end

    let(:message) do
      <<-EOS.strip_heredoc
        # =============================
        # user_stocks
        # =============================

        # index_user_stocks_on_user_id is a left-prefix of index_user_stocks_on_user_id_and_article_id
        # To remove this duplicate index, execute:
        ALTER TABLE `user_stocks` DROP INDEX `index_user_stocks_on_user_id`;
      EOS
    end

    it "should call IndexShotgun::Analyzer#perform" do
      expect(IndexShotgun::Analyzer).to receive(:perform) { response }
      subject
    end
  end
end
