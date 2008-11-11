namespace :batch do
  namespace :tmp do 
    desc "Count all temporary posts"
    task :count => :environment do
      puts "There are #{Post.tmp.count} temporary posts."
    end
    
    desc "Delete all temporary posts"
    task :delete_all => :environment do
      puts "#{Post.tmp.delete_all} temporary post(s) deleted."
    end
  end
end
