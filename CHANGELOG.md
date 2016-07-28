# PushType changelog

## Version 0.9.0

* Version 0.9.0 is [Rails 5 compatible](https://discuss.pushtype.org/t/rails-5/47) (and still 4.2+).
* Much better syntax highlighting in the WYSIWYG code view - 035493bbcf59364bdd3ae05f4bccaefb3d36f773
* Fixed issue where WYSIWYG toolbar option resulted in incorrect toolbar - 035493bbcf59364bdd3ae05f4bccaefb3d36f773
* Fixed issue where native confirm boxes were used instead of Reveal modals - 6436d11be507835c57a877f9d34b6f6bc17b0375

[Compare all changes](https://github.com/pushtype/push_type/compare/0.9.0...0.8.2)

### Version 0.8.2

* Upgraded Froala editor to resolve toolbar glitch bug in Chrome - 7f1b1797d7f6839be50b3191fa3a05ab28ddabd6
* Fixed Foundation and Vue initialization bug - 7f1b1797d7f6839be50b3191fa3a05ab28ddabd6

[Compare all changes](https://github.com/pushtype/push_type/compare/0.8.2...0.8.1)

### Version 0.8.1

* Fixed issue where multiple WYSIWYGs resulted in incorrect toolbar being used - c1836beb2104f73f5089b412d2e4743b3d6192e2

[Compare all changes](https://github.com/pushtype/push_type/compare/0.8.1...0.8.0)

## Version 0.8.0

* Major rewrite of the admin front end assets, replacing AngularJS with Vue.js
* New custom Froala editor plugin, integrating with media library - ad1f3506039f85fd07bc5a5edb9f75c030ffb0fb
* Refactored WYSIWYG field as part of admin gem (instead of own gem) -68fc9c21557d548b768996cd41acc79a22eb6aa0
* Upgraded to latest Froala editor version
* Taxonomies have been deprecated (they will return one day) - 60cf5d1961acbbf178133086b9276a90187934b3

[Compare all changes](https://github.com/pushtype/push_type/compare/0.8.0...0.7.0)
