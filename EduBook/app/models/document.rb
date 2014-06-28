class Document < ActiveRecord::Base
	has_attached_file :avatar
	validates :comment, :length => { :maximum => 100 }
	
	validates_attachment_content_type :avatar, :content_type => ["application/pdf"]

end