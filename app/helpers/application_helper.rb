# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def jquery_onload(&block)
    content_for(:jquery_onload) do
      javascript_tag "$(document).ready(function() { #{capture(&block)} });"
    end
  end

  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options), block.binding)
  end

	def with_pagination(entries, options={}, &block)
	  defaults = { :entries => entries, :head => true, :tail => true }
	  defaults.merge!(options)
	  block_to_partial('shared/pagination', defaults, &block)
  end

	def page_title(title, htag=:h2)
	  @title = strip_tags(title)
		content_tag htag, title, :class => 'page_title'
	end
	
	def span_tag(value)
		content_tag :span, value
	end
	
	def button_link_to(name, options = {}, html_options = {})
		link_to(span_tag(name), options, html_options.merge(:class => 'button'))
	end

  def thumb_image_tag(source, options={})
    class_type = (options[:type] == :book) ? 'book' : ''
    content_tag :div, :class => "thumb #{class_type} float left" do
      image_tag(source, options)
    end
  end

  def empty_msg_for(collection, msg='항목이 없습니다.', tag=:div)
    content_tag tag, :class => 'empty rounded' do 
      msg 
    end if collection.empty?
  end

  def tr(name, value)
    "<tr><td>#{name}</td><td>#{value}</td>" #unless strip_links(value).blank?
  end

  def human_date(date)
    if date.to_date == Date.today
     "오늘"
    else  
	    date.year == Date.today.year ? date.to_s(:kmd) : date.to_s(:kymd)
    end  
  end

  def human_time(datetime)
    human_date(datetime) + ' ' + datetime.to_s(:khm)
  end

  def link_to_alert(name, msg, *args, &block)
    link_to_function name, ["alert('#{msg}')", *args], &block
  end
  
  def current_page_in?(*paths)
    # paths.inject(false) { |b, path| b | current_page?(path) }
    paths.inject(false) { |b, path| b | (request.request_uri == path || request.request_uri.include?(path + '/')) }
  end
end
