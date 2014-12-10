module PushType
  class User < ActiveRecord::Base

    include PushType::Customizable

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    default_scope { order(:name) }

    def initials
      chunks = name ? name.split(' ') : []
      chunks.slice!(1..-2)
      chunks.map { |n| n[0] }.join.upcase
    end
    
  end
end
