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

Convert a Common Cartridge into HTML

    $ cc2html migrate <path-to-cc-backup> <path-to-html-export-directory>

Or into an epub

    $ cc2html migrate <path-to-cc-backup> <path-to-epub-export-directory> --format=epub
    # then zip of the contents of the folder into a .epub

## Todo

 * Oh so much!
 * Support converting all Common Cartridge versions
 * Create chapters from organization sections
 * Quiz conversion
 * make epub zip automatically

## Contributing

Run the tests:

    $ bundle exec rake

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
