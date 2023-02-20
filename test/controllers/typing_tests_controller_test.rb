require 'test_helper'

class TypingTestsControllerTest < ActionController::TestCase
  fixtures :extracts 

  test "when mode is words a random selection of words specified by the size is assigned to @text" do
    get :index, params: { mode: "words", size: "Small" }
    assert_equal 25, assigns(:text).split.size
  end

  test "when mode is quote, a random quote of specified size is assigned to @text" do
    get :index, params: { mode: "quote", size: "Medium"}
    assert_includes (25..50), assigns(:text).split.size 
  end

  test "when mode is timed, assigns all 200 words from WORDS in a random order to @text" do
    get :index, params: { mode: "timed" }
    assert_equal 100, assigns(:text).split.size
    assert_not_equal extracts(:WORDS).extract_text.split, assigns(:text).split
  end
end
