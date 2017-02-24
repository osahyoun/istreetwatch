class AddAttachmentDocumentToPublications < ActiveRecord::Migration
  def self.up
    change_table :publications do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :publications, :document
  end
end
