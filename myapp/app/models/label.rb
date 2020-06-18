class Label < ApplicationRecord
  has_many :task_label_relationships, dependent: :destroy
  has_many :tasks, through: :task_label_relationships

  validates :name, presence: true, uniqueness: true
end
