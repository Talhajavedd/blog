class Article < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	has_many :comments, dependent: :destroy


	# # validate do |school|
 # #    article.comments.each do |comment|
 # #      next if comment.valid?
 # #      comment.errors.full_messages.each do |msg|
 # #        # you can customize the error message here:
 # #        errors[:base] << "Student Error: #{msg}"
 # #      end
 # #    end
 #  end
end
