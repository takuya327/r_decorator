class Book < ActiveRecord::Base
  belongs_to :author
  attr_accessible :title
end
