class BlogPost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: { message: "в посте должна быть обязательно" }
end
