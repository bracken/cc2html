# cc2html

cc2html will convert Common Cartridge 1.3 packages into html or epub format

Common Cartridge information: http://www.imsglobal.org/cc/index.html

Use the [Github Issues](https://github.com/instructure/cc2html/issues?state=open)
for feature requests and bug reports.

## Installation/Usage

### Command line
Install RubyGems on your system, see http://rubygems.org/ for instructions.
Once RubyGems is installed you can install this gem:

    $ gem install cc2html

Convert a Common Cartridge into EPUB

    $ cc2html convert --format=epub <path-to-cc-backup> <name-of-epub-without-extension>

Or into HTML (mostly broken) :)

    $ cc2html convert <path-to-cc-backup> <path-to-html-export-directory>

## Todo

 - [ ] Oh so much!
 - [ ] Support converting all Common Cartridge versions
 - [x] Create chapters from organization sections
 - [ ] Quiz conversion
 - [ ] Styles so it looks good
 - [ ] Configurable styles
 - [ ] Write epub/html output tests
 - [ ] Make HTML output work
 - [ ] Make HTML/EPUB code more DRY
 - [ ] Handle CC weblink/topic/assignment/LTI types better
 - [x] Automatically zip up epub

## Contributing

Run the tests:

    $ bundle exec rake

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
