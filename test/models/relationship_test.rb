require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:joseph).id,
                                     followed_id: users(:jonah).id)
  end
  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    joseph = users(:joseph)
    jonah = users(:jonah)
    assert_not joseph.following?(jonah)
    joseph.follow(jonah)
    assert joseph.following?(jonah)
    assert jonah.followers.include?(joseph)
    joseph.unfollow(jonah)
    assert_not joseph.following?(jonah)
  end
end