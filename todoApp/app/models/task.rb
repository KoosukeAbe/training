class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  enum status: { todo: 0, ongoing: 1, done: 2 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :status, inclusion: { in: statuses }
  validates :user, presence: true


  scope :search_by_labels, -> (selected_labels) {
    where(id: TaskLabel.label_id(selected_labels).pluck(:task_id)) if selected_labels.present?
  }

  def self.search_result(title_keyword, current_status, selected_labels)
    search_by_title(title_keyword)
        .search_by_status(current_status)
        .search_by_labels(selected_labels)
  end

  def self.search_by_title(title_keyword)
    title_keyword.presence ? where("title Like ?", "%#{sanitize_sql_like(title_keyword)}%") : all
  end

  def self.search_by_status(current_status)
    current_status.presence ? where(status: current_status) : all
  end

  def self.own_by(user_id)
    where(user_id: user_id)
  end

  def self.order_by_due_date_or_default(due_date_direction)
    if due_date_direction == 'DESC' || due_date_direction == 'ASC'
      order(due_date: due_date_direction.to_sym)
    else
      order(created_at: :desc)
    end
  end
end
