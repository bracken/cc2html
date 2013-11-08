require_relative 'cc_test_helper'

class TestUnitAssignment < Minitest::Test

  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::FLAT_MANIFEST_PATH
    @resources = manifest.resources
    @assignment = @resources.find_by_identifier("Resource1").assignment
  end

  def test_it_gets_assignment_data
    assert_instance_of IMS::CC::Assignment::Assignment, @assignment
    assert_equal 'Cool Assignment', @assignment.title
    assert_equal 'You should turn this in for points. <b>html!</b>', @assignment.text
    assert_equal 'text/html', @assignment.text.texttype
    assert_equal 'Super Secret', @assignment.instructor_text
    assert_equal 'text/plain', @assignment.instructor_text.texttype
    assert_equal true, @assignment.gradable
    assert_equal ['file', 'text'], @assignment.submission_formats
  end
end

class TestUnitZippedAssignment < Minitest::Test
  def setup
    manifest = IMS::CC::Manifest.read CCTestHelper::CARTRIDGE_PATH
    @resources = manifest.resources
  end

  def test_it_parses_reference
    @assignment = @resources.find_by_identifier("I_00012_R").assignment
    assert_instance_of IMS::CC::Assignment::Assignment, @assignment
    assert_equal 2, @assignment.attachments.attachments.count
    assert_equal '../I_00006_Media/angry_person.jpg', @assignment.attachments.attachments[0].href
    assert_equal 'Learner', @assignment.attachments.attachments[0].role
  end

  def test_it_parses_reference2
    @assignment_resource = @resources.find_by_identifier("I_00013_R")
    assert_instance_of IMS::CC::Assignment::Assignment, @assignment_resource.assignment
  end

end