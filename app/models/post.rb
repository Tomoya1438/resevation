class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :admin
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :join_users, through: :joins, source: :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  def joined_by?(user)
    joins.exists?(user_id: user.id)
  end
  
end

