# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Remove field_with_errors wrapper
ActionView::Base.field_error_proc = Proc.new do |html_tag, object|
  html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  html = html.at_css("input") || html.at_css("textarea") || html.at_css("select")
  unless html.nil?
    css_class = html['class'] || ""
    html['class'] = css_class.split.push("error").join(' ')
    html_tag = html.to_s
  end
  html_tag.html_safe
end
