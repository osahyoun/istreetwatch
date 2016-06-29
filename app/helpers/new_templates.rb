module ApplicationHelper
  def render_fragment(name)
    if fragment = Fragment.fetch_by_name(name)
      @template = Liquid::Template.parse(fragment.content)
      @template.render({
        'facebook_share_button' => render_facebook_share_button(),
        'twitter_share_button' => render_facebook_share_button(),
        'email_share_button' => render_facebook_share_button(),
        'pledge_count' => render_pledge_count()
      })
    else
      ""
    end
  end

  def render_facebook_share_button
    "hello"
  end
end
