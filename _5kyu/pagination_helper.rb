# For this exercise you will be strengthening your page-fu mastery.
# You will complete the PaginationHelper class, which is a utility class helpful for querying paging information related to an array.

# The class is designed to take in an array of values and an integer indicating how many items will be allowed per each page.
# The types of values contained within the collection/array are not relevant.

# The following are some examples of how this class is used:

# helper = PaginationHelper.new(['a','b','c','d','e','f'], 4)
# helper.page_count # should == 2
# helper.item_count # should == 6
# helper.page_item_count(0)  # should == 4
# helper.page_item_count(1) # last page - should == 2
# helper.page_item_count(2) # should == -1 since the page is invalid

# # page_ndex takes an item index and returns the page that it belongs on
# helper.page_index(5) # should == 1 (zero based index)
# helper.page_index(2) # should == 0
# helper.page_index(20) # should == -1
# helper.page_index(-10) # should == -1 because negative indexes are invalid

# Solution ________

# TODO: complete this class

class PaginationHelper

  # The constructor takes in an array of items and a integer indicating how many
  # items fit within a single page
  def initialize(collection, items_per_page)
    @ary = collection
    @ipp = items_per_page
  end

  # returns the number of items within the entire collection
  def item_count
    @ary.count
  end

  # returns the number of pages
  def page_count
    (self.item_count.to_f / @ipp ).ceil
  end

  # returns the number of items on the current page. page_index is zero based.
  # this method should return -1 for page_index values that are out of range
  def page_item_count(page_index)
    values = @ary[page_index*@ipp, @ipp]
    values ? values.count : -1
  end

  # determines what page an item is on. Zero based indexes.
  # this method should return -1 for item_index values that are out of range
  def page_index(item_index)
    return -1 if item_index > self.item_count-1 or item_index < 0
    (item_index.to_f/@ipp).floor
  end
end

# TDD _________
# TODO: Replace examples and use TDD development by writing your own tests
# These are some of the methods available:
#   Test.expect(boolean, [optional] message)
#   Test.assert_equals(actual, expected, [optional] message)
#   Test.assert_not_equals(actual, expected, [optional] message)

describe "Solution" do
  before(:each) do
    @helper = PaginationHelper.new(['a','b','c','d','e','f'], 4)
  end
  it "should count number of pages" do
    Test.assert_equals(@helper.page_count, 2, "It does not count number of pages")
  end
  it "should count all items" do
    Test.assert_equals(@helper.item_count, 6, "It does not count all items")
  end
  it "should count elements per page" do
    Test.assert_equals(@helper.page_item_count(0) , 4, "It does not count elements per page")
    Test.assert_equals(@helper.page_item_count(1), 2, "It does not count elements per page")
    Test.assert_equals(@helper.page_item_count(2), -1, "It does not count elements per page")
  end
  it "should get page index of element" do
    Test.assert_equals(@helper.page_index(5), 1, "It does not get page index of element")
    Test.assert_equals(@helper.page_index(2), 0, "It does not get page index of element")
    Test.assert_equals(@helper.page_index(20), -1, "It does not get page index of element")
    Test.assert_equals(@helper.page_index(-10), -1, "It does not get page index of element")
  end
end