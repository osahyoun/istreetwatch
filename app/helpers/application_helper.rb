module ApplicationHelper

  def logo( klass:'' )
    link_to root_path, class: klass do
      image_tag('logo.svg',
        alt: "Report racism and xenophobia",
        onerror: "this.onerror=null; this.src='#{asset_path("logo.png")}'"
      )
    end
  end

end
