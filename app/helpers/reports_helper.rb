module ReportsHelper
  def display_address(report)
    [report.house, report.street, report.town, report.region].
      reject(&:blank?).
      join(", ")
  end

  def static_map_url(lat, lng)
    url = "https://maps.googleapis.com/maps/api/staticmap"

    options = {
      key: "AIzaSyDT0e-2ul1a83yS1dm1VRp-qcMLCDmpPhU",
      center: "#{lat},#{lng}",
      size:   "600x400",
      zoom: 12,
      scale: 2,
      markers: "red|#{@report.lat},#{@report.lng}"
    }

    "#{url}?#{options.to_query}"
  end

  def select_options_for_informant_role
    [
      "Something that happened to me",
      "Something that I witnessed",
      "Something that someone asked for my help to report",
      "Something that I heard about and wanted to report"
    ]
  end

  def select_options_for_type_incident
    [
      "Physical assault",
      "Verbal abuse / insults",
      "Damage to property / vandalism",
      "Threats / intimidation",
      "Hate post",
      "Other"
    ]
  end

  def select_options_for_type_location
    [
      "Street / public park",
      "Public transportation",
      "University / college",
      "Place of worship",
      "Shops",
      "Pub / bar / club",
      "Private residence",
      "Other"
    ]
  end

  def select_options_for_was_reported
    ["Yes", "No", "Don't know"]
  end
end
