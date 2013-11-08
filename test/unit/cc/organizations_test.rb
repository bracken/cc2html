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

  # have to figure out why happy mapper gets all items instead of just 1st children
  #def test_it_creates_item_tree
  #  assert_equal 1, @orgs.organization.item.items.count
  #  assert_equal 4, @orgs.organization.item.items[0].count
  #end

  def test_gets_item_info
    assert_equal "I_00000", @orgs.organization.item.items[0].identifier
    assert_equal "CCv1.3 With Assignment", @orgs.organization.item.items[0].title
    assert_equal '', @orgs.organization.item.items[0].identifierref

    assert_equal "I_00001", @orgs.organization.item.items[1].identifier
    assert_equal "Cool Assignment", @orgs.organization.item.items[1].title
    assert_equal "Resource1", @orgs.organization.item.items[1].identifierref
  end

  def test_item_references_resource
    item = @orgs.find_item_by_identifier('I_00001')
    assert_equal 'Resource1', item.resource.identifier
  end

end
