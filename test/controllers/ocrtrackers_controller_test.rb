require "test_helper"

class OcrtrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ocrtracker = ocrtrackers(:one)
  end

  test "should get index" do
    get ocrtrackers_url
    assert_response :success
  end

  test "should get new" do
    get new_ocrtracker_url
    assert_response :success
  end

  test "should create ocrtracker" do
    assert_difference('Ocrtracker.count') do
      post ocrtrackers_url, params: { ocrtracker: { W.I.P: @ocrtracker.W.I.P } }
    end

    assert_redirected_to ocrtracker_url(Ocrtracker.last)
  end

  test "should show ocrtracker" do
    get ocrtracker_url(@ocrtracker)
    assert_response :success
  end

  test "should get edit" do
    get edit_ocrtracker_url(@ocrtracker)
    assert_response :success
  end

  test "should update ocrtracker" do
    patch ocrtracker_url(@ocrtracker), params: { ocrtracker: { W.I.P: @ocrtracker.W.I.P } }
    assert_redirected_to ocrtracker_url(@ocrtracker)
  end

  test "should destroy ocrtracker" do
    assert_difference('Ocrtracker.count', -1) do
      delete ocrtracker_url(@ocrtracker)
    end

    assert_redirected_to ocrtrackers_url
  end
end
