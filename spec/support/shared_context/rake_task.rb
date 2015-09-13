shared_context :rake_task do
  before do
    RakeSharedContext.rake_dir = TASK_DIR
  end

  include_context "rake"
end
