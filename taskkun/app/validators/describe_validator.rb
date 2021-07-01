class DescribeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || 'は255バイト以内で入力してください') if value.encode('utf-8').bytesize > 255
  end
end
