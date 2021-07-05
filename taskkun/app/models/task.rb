class Task < ApplicationRecord
  scope :sort_by_title_status, ->(title, status){ where('title LIKE ?', "%#{title}%").and(Task.where(status_id: status)) }

  enum status: { waiting: 1, working: 2, complete: 3 }

  validates :title, { length: { minimum: 1, maximum: 100 } }
  validates :description, describe: true
  validates :due_date, due_date: true
end
