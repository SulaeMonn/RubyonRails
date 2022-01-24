class Post < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :title, :length => {:maximum => 255}
  validates :title, :uniqueness => {:message => "already taken" }

  #export
  def self.to_csv
    attributes = %w{title description status}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |post|
        csv << attributes.map{ |attr| post.send(attr) }
      end
    end
  end

  #import
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Post.create! row.to_hash
    end
  end

end
