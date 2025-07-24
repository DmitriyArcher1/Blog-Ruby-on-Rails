class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: "User"
  belongs_to :subscribed_to, class_name: "User"
  validates :subscriber_id, uniqueness: { scope: :subscribed_to_id, message: "You are already subscribed." }
end
