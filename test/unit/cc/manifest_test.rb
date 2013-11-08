require_relative 'cc_test_helper'

class TestUnitManifest < Minitest::Test
  def test_it_has_metadata
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    assert_instance_of IMS::CC::Metadata, manifest.metadata
  end
end
