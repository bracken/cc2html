require_relative 'cc_test_helper'

class TestUnitOrganizations < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @orgs = manifest.organizations
  end

  def test_it_gets_organizations
    assert_instance_of IMS::CC::Organizations::Organizations, @orgs
    assert_instance_of IMS::CC::Organizations::Organization, @orgs.organization
    assert_equal 'O_1', @orgs.organization.identifier
    assert_equal 'rooted-hierarchy', @orgs.organization.structure
  end

  def test_it_creates_item_tree
    assert_instance_of IMS::CC::Organizations::Item, @orgs.organization.item
    assert_equal 2, @orgs.organization.item.items.count
    assert_equal 4, @orgs.organization.item.items[0].items.count
    assert_equal 1, @orgs.organization.item.items[0].items[3].items.count
    assert_equal 1, @orgs.organization.item.items[1].items.count
  end

  def test_gets_item_info
    folder1 = @orgs.organization.item.items[0]
    assert_equal "I_00000", folder1.identifier
    assert_equal "CCv1.3 With Assignment", folder1.title
    assert_equal '', folder1.identifierref

    assert_equal "I_00001", folder1.items[0].identifier
    assert_equal "Cool Assignment", folder1.items[0].title
    assert_equal "Resource1", folder1.items[0].identifierref

    sub_folder = folder1.items.last
    assert_equal "I_00003", sub_folder.identifier
    assert_equal "Child Folder", sub_folder.title
    assert_equal "", sub_folder.identifierref

    assert_equal "I_00004", sub_folder.items[0].identifier
    assert_equal "LTI Launch", sub_folder.items[0].title
    assert_equal "Resource4", sub_folder.items[0].identifierref

    folder2 = @orgs.organization.item.items[1]
    assert_equal "I_2", folder2.identifier
    assert_equal "Folder 2", folder2.title
    assert_equal "", folder2.identifierref

    assert_equal "I_00005", folder2.items[0].identifier
    assert_equal "LTI Launch", folder2.items[0].title
    assert_equal "Resource4", folder2.items[0].identifierref
  end

  def test_item_references_resource
    item = @orgs.find_item_by_identifier('I_00001')
    assert_equal 'Resource1', item.resource.identifier
  end

end
