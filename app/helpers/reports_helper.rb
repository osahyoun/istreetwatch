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
end
