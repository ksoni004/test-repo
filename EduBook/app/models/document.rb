class Document < ActiveRecord::Base
	has_attached_file :avatar
	validates :comment, :length => { :maximum => 100 }
	
	validates_attachment_content_type :avatar, :content_type => ["application/pdf", "application/msword", /\Aimage\/.*\Z/, "application/zip", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.openxmlformats-officedocument.wordprocessingml.document","application/text/plain", "application/vnd.openxmlformats-officedocument.presentationml.presentation", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]
end