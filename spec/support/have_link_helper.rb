# frozen_string_literal: true

module HaveLinkHelper
  def have_link_helper(link)
    have_xpath("(//form[@action='#{link}'] | //a[@href='#{link}'])")
  end
end
