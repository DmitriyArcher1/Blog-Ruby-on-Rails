class Like < ApplicationRecord
  belongs_to :blog_post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :blog_post_id, message: "Вы можете лайкнуть пост только один раз." }
end
