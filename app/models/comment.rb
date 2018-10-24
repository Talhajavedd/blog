class Comment < ActiveRecord::Base
	belongs_to :article
	validates :commenter, :body, length: { in: 6..20 }
	paginates_per 2
end
