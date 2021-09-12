require "application_system_test_case"

class OcrtrackersTest < ApplicationSystemTestCase
  setup do
    @ocrtracker = ocrtrackers(:one)
  end

  test "visiting the index" do
    visit ocrtrackers_url
    assert_selector "h1", text: "Ocrtrackers"
  end

  test "creating a Ocrtracker" do
    visit ocrtrackers_url
    click_on "New Ocrtracker"

    fill_in "W.i.p", with: @ocrtracker.W.I.P
    click_on "Create Ocrtracker"

    assert_text "Ocrtracker was successfully created"
    click_on "Back"
  end

  test "updating a Ocrtracker" do
    visit ocrtrackers_url
    click_on "Edit", match: :first

    fill_in "W.i.p", with: @ocrtracker.W.I.P
    click_on "Update Ocrtracker"

    assert_text "Ocrtracker was successfully updated"
    click_on "Back"
  end

  test "destroying a Ocrtracker" do
    visit ocrtrackers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ocrtracker was successfully destroyed"
  end
end
