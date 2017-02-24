class Publication < ApplicationRecord
  has_attached_file :document, styles: { large: ["600x848>", :png], medium: ["250x353>", :png], thumb: ["141x100>", :png] }

  validates( :title, :summary, presence: true )

  validates_attachment :document, presence: true,
    content_type: { content_type: "application/pdf" },
    size: { in: 0..2.megabytes }
  end
