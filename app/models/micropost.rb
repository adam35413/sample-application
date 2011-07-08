# == Schema Information
# Schema version: 20110626181448
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  #Database associations
  belongs_to :user

  #Attributes accessible
  attr_accessible :content

  #Attribute restrictions
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => "microposts.created_at DESC"

  #Return microposts from the users being followed by the given user
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    # Return an SQL condiction for users followed by the given user.
    # We include the user's own id as well.
    def self.from_users_followed_by(user)
      following_ids =  %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { :user_id => user } )
    end

  
end
