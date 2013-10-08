$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'box-view/version'

spec = Gem::Specification.new do |s|
  s.name = 'box-view'
  s.version = BoxView::VERSION
  s.summary = 'Ruby wrapper for the Box View API which maintains the compatibility with Crocodoc API as much as possible'
  s.description = 'The Box View API lets you upload documents and then generate secure and customized viewing sessions for them. See http://developers.box.com/view/ for details.'
  s.authors = ['Brandon Goldman', 'Kenta Yasukawa']
  s.email = ['kenta.yasukawa@gmail.com']
  s.homepage = 'http://developers.box.com/view/'
  s.require_paths = %w{lib}

  s.add_dependency('rest-client', '~> 1.4')
  s.add_dependency('json', '~> 1.1')

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
