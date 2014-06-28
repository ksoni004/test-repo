class AddAttachmentToDocuments < ActiveRecord::Migration
  def change
  	add_attachment :documents, :avatar
  end
end
