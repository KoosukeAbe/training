class Task < ApplicationRecord
  scope :created_latest, -> {order(created_at: :desc)}
  scope :id_oldest, -> {order(created_at: :asc)}
  scope :due_date_latest, -> {order(due_date: :desc)}

  validates :title, {length: {in: 1..100} }
  validates :description, {length: {maximum: 255} }
  validates :due_date, {format: {with: /\A\d{1,4}\-\d{1,2}\-\d{1,2}\Z/ } }
end
