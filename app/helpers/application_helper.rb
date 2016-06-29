module ApplicationHelper
  def render_fragment(name)
    if fragment = Fragment.fetch_by_name(name)
      ERB.new(fragment.content).result(binding)
    else
      ""
    end
  end

  def pledge_count
    Pledge.cached_count
  end
end
