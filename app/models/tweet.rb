# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  retweet_id :integer
#
class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :retweet

  has_many :retweets

  before_validation :set_retweet
  after_create :make_new_hastag
  has_many_attached :images

  def retweet!(user)
    retweets.create(user:user)
  end

  def is_retweet?
    !retweet_id.nil?
  end
  
  def set_retweet
    
  end

  def make_new_hastag
    self.body.scan(/#\w+/).each do |hashtag|
      tag = Hashtag.where(identifier:hashtag).first_or_create
      tag.hashtag_tweets.create(tweet:self)
      tag.update(mentions: tag.mentions + 1)
    end
  end
end
