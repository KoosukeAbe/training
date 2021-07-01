class Task < ApplicationRecord
  scope :created_latest, -> { order(created_at: :desc) }
  scope :id_oldest, -> { order(created_at: :asc) }
  scope :due_date_latest, -> { order(due_date: :desc) }

  enum status: { waiting: 1, working: 2, complete: 3 }
  validates :title, { length: { minimum: 1, maximum: 100 } }
  validates :description, describe: true
  validates :due_date, due_date: true
end
