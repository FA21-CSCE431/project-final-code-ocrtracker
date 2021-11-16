# frozen_string_literal: true

class SubmissionsFormBuilder < ActionView::Helpers::FormBuilder
  def text_or_time_field(attribute, options = {})
    if options[:unit_name].starts_with?('time')
      if options[:value].nil?
        label('minutes') + text_field('minutes') + label('seconds') + text_field('seconds')
      else
        label('minutes') + text_field('minutes', value: (options[:value].to_i / 60)) + label('seconds') + text_field('seconds', value: (options[:value].to_f % 60).round(3))
      end
    else
      label('unit_value', 'Number') + text_field(attribute, value: options[:value])
    end
  end
end
