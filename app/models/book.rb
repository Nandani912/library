class Book < ApplicationRecord
  belongs_to :user
  def self.ransackable_attributes(auth_object = nil)
    ["author", "title"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
