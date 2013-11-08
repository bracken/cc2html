require_relative 'cc_test_helper'

class TestUnitWebLink < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @resources = manifest.resources
    @weblink = @resources.find_by_identifier("Resource3").web_link
  end

  def test_it_gets_weblink_data
    assert_instance_of IMS::CC::WebLink, @weblink
    assert_equal 'Open2.net: Science and Nature', @weblink.title
    assert_equal 'http://www.open2.net/sciencetechnologynature/', @weblink.url.href
  end

end

class TestUnitZippedWebLinks < Minitest::Test
  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::CARTRIDGE_PATH
    @resources = manifest.resources
  end

  def test_it_parses_reference
    @weblink_resource = @resources.find_by_identifier("I_00005_R")
    assert_instance_of IMS::CC::WebLink, @weblink_resource.web_link
  end

  def test_it_parses_reference2
    @weblink_resource = @resources.find_by_identifier("I_00007_R")
    assert_instance_of IMS::CC::WebLink, @weblink_resource.web_link
  end

end