# frozen_string_literal: true

class Task < ApplicationRecord
  enum priority: %i[low normal high].freeze
  ORDER_BY_VALUES = %w[due_date priority created_at].freeze
  ORDER_VALUES = %w[ASC DESC].freeze

  # タスク名のチェック
  validates :name, presence: true, length: { maximum: 20 }
  # 説明文のチェック
  validates :description, length: { maximum: 200 }
  # 優先順位のチェック
  validates :priority, presence: true, inclusion: { in: self.priorities.keys }
  # 期限のチェック
  validate :validate_due_date
  # ユーザIDのチェック
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.search(order_by, order)
    order(order_by => order)
  end

  private

  def validate_due_date
    # due_dateの空チェック
    return errors.add(:due_date, I18n.t('activerecord.errors.models.task.attributes.due_date.blank')) if due_date.blank?
    # due_dateは、'YYYY-MM-DD'、または、キャスト前の状態が{1=>YYYY, 2=>MM, 3=>DD}の形式のみ許容する
    return if date_hash_format?(:due_date, due_date_before_type_cast)
    return if date_hyphen_format?(:due_date, due_date)
    errors.add(:due_date, I18n.t('activerecord.errors.models.task.attributes.due_date.invalid'))
  end

  def date_hyphen_format?(column, date_hyphen)
    split_date = date_hyphen.to_s.split('-')
    return false unless split_date.count.equal?(3)
    validate_date(column, split_date[0].to_i, split_date[1].to_i, split_date[2].to_i)
    true
  end

  def date_hash_format?(column, hash_date)
    return false unless hash_date.class.equal?(Hash) && hash_date.length == 3
    validate_date(column, hash_date[1].to_i, hash_date[2].to_i, hash_date[3].to_i)
    true
  end

  def validate_date(column, year, month, day)
    errors.add(column, I18n.t("activerecord.errors.models.task.attributes.#{column}.invalid")) unless Date.valid_date?(year, month, day)
  end
end
