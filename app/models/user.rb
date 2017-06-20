class User < ApplicationRecord
  has_many :likes

  validates :name, presence: true, uniqueness: true
  validates :password, :length => {:in => 4..15}
  validates :name, :length => {:maximum => 12}

  has_secure_password

  def create_avatar(avatar_file)
    path = File.join(Rails.public_path, 'avatars', self.id.to_s)
    
    FileUtils.mkdir_p(path) unless File.exist?(path)
    
    File.open(File.join(path, "avatar_#{self.name}.png"), 'wb') do |file|
      file.puts(avatar_file.read)
    end
  end

  def admin?
    name == "admin"
  end
end
