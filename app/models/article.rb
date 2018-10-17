class Article < ActiveRecord::Base
	validates :text, :title, presence: { message: "must be given please" }
	before_validation :set_text
	belongs_to :user
	has_many :comments, dependent: :destroy
	private
	def set_text
		unless title.blank?
			self.text = title if text.blank?
		end
	end
end