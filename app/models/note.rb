class Note < ActiveRecord::Base
  #verify that the user gave the note a title and indicated who crated the note
  #if values are not specified in the title and the user fields the note won't be created
  validates :title, presence: true
  belongs_to :user
  has_many :accessors, dependent: :destroy


end
