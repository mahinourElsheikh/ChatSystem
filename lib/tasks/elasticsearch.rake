namespace :elasticsearch do
  task :build_index => :environment do
    Message.__elasticsearch__.create_index!
    Message.import
    Message.__elasticsearch__.refresh_index!
  end
end
