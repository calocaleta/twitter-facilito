# == Schema Information
#
# Table name: followers
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Follower < ApplicationRecord
  belongs_to :user
end
