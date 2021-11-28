# frozen_string_literal: true

class SubmissionsFormBuilder < ActionView::Helpers::FormBuilder
  def text_or_time_field(attribute, options = {})
    if options[:unit_name].starts_with?('time')
      if options[:value].nil?
        label('minutes') + number_field('minutes', required: true) + label('seconds') + number_field('seconds', required: true)
      else
        label('minutes') + number_field('minutes', value: (options[:value].to_i / 60),
                                                   required: true) + label('seconds') + number_field('seconds', value: (options[:value].to_f % 60).round(3), required: true)
      end
    else
      label('unit_value', 'Number') + number_field(attribute, value: options[:value], required: true)
    end
  end
end
