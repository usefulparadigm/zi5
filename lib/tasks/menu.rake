def menu_config_file
  File.join("config", "menu.yml")
end

def top_nav_file
  File.join("app", "views", "layouts", "_top_nav.html.erb")
end

def side_nav_file
  File.join("app", "views", "layouts", "_side_nav.html.erb")
end

namespace :menu do
  desc "Generates default menu templates from config/menu.yml"
  task :build => :environment do
    menu = YAML.load(File.open(menu_config_file))
    top_nav_html = MenuBuilder.create_top_nav(menu, false)
    side_nav_html = MenuBuilder.create_side_nav(menu, true)
    puts top_nav_html
    File.open(top_nav_file, 'w') { |f| f.write top_nav_html }
    File.open(side_nav_file, 'w') { |f| f.write side_nav_html }
  end
  
  desc "Geenrates vertical type menu templates from config/menu.yml"
  task :'build:vertical' => :environment do 
    menu = YAML.load(File.open(menu_config_file))
    top_nav_html = ''
    side_nav_html = MenuBuilder.create_side_nav(menu)
    File.open(top_nav_file, 'w') { |f| f.write top_nav_html }
    File.open(side_nav_file, 'w') { |f| f.write side_nav_html }
  end
  
  task :links => :environment do
    menu = YAML.load(File.open(menu_config_file))
    menu.each do |m|
      puts MenuBuilder.find_first_link(m)
    end
  end

  desc "Geenrates horizontal type menu templates from config/menu.yml"
  task :'build:horizontal' => :environment do 
    menu = YAML.load(File.open(menu_config_file))
    top_nav_html = MenuBuilder.create_top_nav(menu)
    side_nav_html = ''
    File.open(top_nav_file, 'w') { |f| f.write top_nav_html }
    File.open(side_nav_file, 'w') { |f| f.write side_nav_html }
  end
end
