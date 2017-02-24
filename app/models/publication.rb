class Publication < ApplicationRecord
  has_attached_file :document, styles: { medium: ["250x250#", :png], thumb: ["100x100#", :png] }

  validates( :title, :summary, presence: true )

  validates_attachment :document, presence: true,
    content_type: { content_type: "application/pdf" },
    size: { in: 0..2.megabytes }
  end
