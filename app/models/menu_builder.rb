class MenuBuilder

  def self.create_top_nav(data, cascading = true)
    returning("<ul id=\"top_nav\" class=\"sf-menu\">\n") do |html|
      if cascading
        data.each { |top_menu| html << create_menu(top_menu) }
      else
        data.each do |top_menu|
          html << "<li class=\"<%= 'current' if current_page_in?(#{find_all_links(top_menu)}) %>\">"
          html << "<a href=\""
          href = find_first_link(top_menu)
          html << href || "#"
          html << "\">#{top_menu.keys.first}</a></li>"
        end
      end
      html << "</ul>"
    end
  end

  def self.create_side_nav(data, submenu = false)
    returning("<ul id=\"side_nav\" class=\"sf-menu sf-vertical\">\n") do |html|
      unless submenu
        data.each { |top_menu| html << create_menu(top_menu) }
      else
        data.each_with_index do |top_menu, idx|
          # first_link = find_first_link(top_menu)
          # unless first_link.nil?
            html << "\n<% #{ idx == 0 ? 'if' : 'elsif' } current_page_in?(#{find_all_links(top_menu)}) %>"
            top_menu.values.first.each do |menu|
              html << create_menu(menu)
            end
          # end
        end
        html << "\n<% end %>"
      end
      html << "\n</ul>"
    end
  end

private

  def self.init_db(data)
    title = data.keys.first
    path = data.values.first
    if path =~ /^\/boards\/(.*?)$/
      board = Board.find_or_initialize_by_name($1)
      board.title = title
      board.save
    elsif path =~ /^\/pages\/(.*?)$/
      page = Page.find_or_initialize_by_name($1)
      page.title = title
      page.save
    end
  end

  def self.make_link(data)
    returning("") do |html|
      html << "<a href=\""
      if data.values.first.class == Array 
        html << "#"
      else
        init_db(data)
        html << data.values.first
      end
      html << "\">" << data.keys.first << "</a>"
    end
  end

  def self.create_menu(data)
    returning("") do |html|
      if data.class == Array
        html << "\n<ul>\n"
        data.each { |menu| html << create_menu(menu) }
        html << "</ul>\n"
      elsif data.class == Hash
        html << "<li class=\"<%= 'current' if current_page_in?(#{find_all_links(data)}) %>\">"
        html << make_link(data)
        html << create_menu(data.values.first) if data.values.first.class == Array
        html << "</li>\n"
      end
    end
  end

  def self.find_first_link(menu)
    if menu.class == Hash
      find_first_link(menu.values.first)
    elsif menu.class == Array
      find_first_link(menu.first)
    else
      return menu  
    end
  end

  def self.find_all_links(menu)
    returning([]) do |links|
      if menu.class == Array 
        menu.each { |m| links << find_all_links(m) }
      elsif menu.class == Hash
        links << find_all_links(menu.values)
      else
        links << "'#{menu}'"
      end
    end.join(', ')
  end

end
