require_relative 'cc_test_helper'

class TestUnitTopic < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @resources = manifest.resources
    @topic = @resources.resources[1].topic
  end

  def test_it_gets_topic_data
    assert_instance_of IMS::CC::Topic, @topic
    assert_equal 'Assignment Discussions', @topic.title
    assert_equal 'Discuss your results from the first assignment.', @topic.text
    assert_equal 'text/html', @topic.text.texttype
    assert_equal 2, @topic.attachments.attachments.count
    assert_equal 'test1.jpg', @topic.attachments.attachments[0].href
  end

end

class TestUnitZippedTopics < Minitest::Test
  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::CARTRIDGE_PATH
    @resources = manifest.resources
    @topic_resource = @resources.resources.find{|r|r.identifier == 'I_00006_R'}
  end

  def test_it_parses_reference
    assert_instance_of IMS::CC::Topic, @topic_resource.topic
  end

  def test_it_parses_reference2
    @topic_resource = @resources.resources.find{|r|r.identifier == 'I_00009_R'}
    assert_instance_of IMS::CC::Topic, @topic_resource.topic
  end

end