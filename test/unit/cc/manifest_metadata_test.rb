require_relative 'cc_test_helper'

class TestUnitMetadata < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @meta = manifest.metadata
  end

  def test_it_has_default_namespace_data
    assert_equal @meta.schema, 'IMS Common Cartridge'
    assert_equal @meta.schemaversion, '1.3.0'
  end

  def test_it_gets_general_lom
    assert_instance_of IMS::CC::Lom::Lom, @meta.lom
    assert_instance_of IMS::CC::Lom::General, @meta.lom.general
    assert_instance_of IMS::CC::Lom::Title, @meta.lom.general.title
    assert_instance_of IMS::CC::Lom::Description, @meta.lom.general.description
    assert_equal "Common Cartridge Test", @meta.lom.general.title.title
    assert_equal "CC 1.3 test with extension", @meta.lom.general.description.description
    assert_equal ['Sample', 'Sample2'], @meta.lom.general.keywords.map(&:keyword)
    assert_equal 'yes', @meta.lom.rights.copyrightAndOtherRestrictions.value
    assert_equal 'Private (Copyrighted) - http://en.wikipedia.org/wiki/Copyright', @meta.lom.rights.description.description
  end

end
