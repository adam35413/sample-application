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

  
end
