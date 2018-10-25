class Attachment < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	
	has_attached_file :avatar
	validate :check_type, on: :create
	do_not_validate_attachment_file_type :avatar
 	def check_type
 		if attachable_type == "User"
			unless avatar_content_type.match(/\Aimage\/.*\z/)  
				errors.add(:avatar_content_type, "must be an image")
			end
		elsif attachable_type == "Article"
			 unless ["application/pdf"].include? avatar_content_type  
				errors.add(:avatar_content_type, "must be an image or pdf")
			end
		end
			
	end
end