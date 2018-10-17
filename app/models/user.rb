class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, numericality: { only_integer: true }
	has_one :article, dependent: :destroy
	has_many :comments, dependent: :destroy
	before_create do
    self.username = username.downcase
  end
  def to_param 
    username
  end
end
