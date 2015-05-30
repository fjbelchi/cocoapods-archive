# cocoapods-archive

cocoapods-archive is a CocoaPods plugin which archive your project.
First the plugin executes a `pod install` to keep your pods up to date, once
`pod install` is finished, the plugin creates a tag with the version specified and
it will push the tag to the origin.

After that, a Zip file is created with all the files of the project. Including Pods directory
for a backup in case the directory doesn't belong to the repository.

## Installation

    $ gem install cocoapods-archive

## Usage

    $ pod archive 1.0

## Authors

* Francisco J. Belchi (@fjbelchi) http://www.fjbelchi.com

* Alejandro Martinez (@alexito4) http://www.alejandromp.com
