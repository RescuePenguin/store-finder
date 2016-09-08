# The Company model will act mostly as an owner for their locations and provide a relation that connects them all.
# it could potentially have other uses, like managing, adding to, and removing the locations within.
class Company < ApplicationRecord
  has_many :locations
end
