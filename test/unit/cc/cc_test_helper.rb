require 'minitest/autorun'
require 'ims/cc'
require 'pp'

module CCTestHelper
  CARTRIDGE_PATH = File.expand_path("../../../fixtures/cc_full_test.zip", __FILE__)
  FLAT_MANIFEST_PATH = File.expand_path("../../../fixtures/flat_imsmanifest.xml", __FILE__)
end