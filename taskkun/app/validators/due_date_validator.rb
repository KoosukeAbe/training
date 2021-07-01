class DueDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    is_date = begin
      !!Date.parse(value)
    rescue StandardError
      false
    end
    record.errors.add(attribute, options[:message] || 'の日付が不正です') if is_date
  end
end
