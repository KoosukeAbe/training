class Task < ApplicationRecord
  validates :name, presence: true,
                   length: {
                     minimum: 1,
                     maximum: 50,
                   }

  validates :description, length: {maximum: 100}
end
