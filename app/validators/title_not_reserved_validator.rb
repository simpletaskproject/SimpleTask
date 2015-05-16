class TitleNotReservedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if ["All","Today"].include?(value)
      record.errors[attribute] << (options[:message] || "invalid title")
    end
  end
end
