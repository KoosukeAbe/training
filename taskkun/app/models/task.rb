class Task < ApplicationRecord
  scope :created_latest, -> {order(created_at: :desc)}
  scope :id_oldest, -> {order(created_at: :asc)}
end
