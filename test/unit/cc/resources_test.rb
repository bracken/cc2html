require_relative 'cc_test_helper'

class TestUnitResources < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @resources = manifest.resources
  end

  def test_it_gets_resources
    assert_instance_of IMS::CC::Resources::Resources, @resources
  end

  def test_gets_resource_info
    assert_instance_of IMS::CC::Resources::Resource, @resources.resources[0]
    assert_equal 'Resource1', @resources.resources[0].identifier
    assert_equal 'assignment_xmlv1p0', @resources.resources[0].type
    assert_equal 'assignment', @resources.resources[0].intendeduse
  end

  def test_gets_dependency_info
    assert_equal 'Resource2', @resources.resources.last.dependencies[0].identifierref
  end

  def test_it_recognizes_inline
    assert_equal true, @resources.resources[1].inline?
  end

end

class TestUnitZippedResources < Minitest::Test
  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::CARTRIDGE_PATH
    @resources = manifest.resources
  end

  def test_it_gets_resources
    assert_instance_of IMS::CC::Resources::Resources, @resources
  end

  def test_gets_file_info
    assert_equal 3, @resources.resources.find{|r|r.identifier == 'f5'}.files.count
    assert_equal 'I_00001_R/Learning_Objectives.html', @resources.resources[0].files[0].href
  end

  def test_it_recognizes_not_inline
    @topic_resource = @resources.resources.find{|r|r.identifier == 'I_00006_R'}
    assert_equal false, @topic_resource.inline?
  end
end
