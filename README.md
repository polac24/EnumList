# EnumList

[![Build Status][build-badge]][build-url]
[![Coverage Status][codecov-badge]][codecov-url]
[![CocoaPods][cocoapods-badge]][cocoapods-url]
[![CocoaPodsPlatform][cocoapods-platform-badge]][cocoapods-platform-url]
[![Fastlane][fastlane-badge]][fastlane-url]
[![Swift][swift-badge]][swift-url]
[![License][mit-badge]][mit-url]


Library to enumerate all enum cases (for `Swift` or `Int` `RawValue`). 

EnumList does not relay non memory introspection so it is safe by design and becomes stable in the future Swift releases.


## Installation

### CocoaPods

Use [CocoaPods](http://cocoapods.org) to install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `EnumList` into your  project, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
  platform :ios, '9.0'
  use_frameworks!

  target 'TARGET' do
    pod 'EnumList/Core'
  end
```

Then, run the following command:

```bash
$ pod install
```

### Prerequisites

In order to make your `enum` (with `String` rawValue) compatible with `EnumList`, add conformance to protocols `EnumListStringRaw<NAME_OF_YOUR_ENUM.Values>, RawRepresentable` and define nested struct `Values`. 

*Althouh you have free choose the name and place to define `struct` that conformances to `EnumValues` (e.g. `YourEnumName.Values`), it is recommended to keep it as a nested type.*

```swift
private enum YourEnumName: EnumListStringRaw<YourEnumName.Values>, RawRepresentable{
   struct Values:EnumValues {
      typealias Element = YourEnumName
      static var allRaws:Set<String> = []
   }
   case caseNo1 = "case1"
   case caseNo2 = "case2"
   //case caseNo3 = "case2" - compile error: RawValues have to be unique
}

YourEnumName.Values.all //  Set([.caseNo1, .caseNo2]) 
YourEnumName.Values.allRaws //  Set(["case1", "case2"])

```

All your cases exist in static `Set<YourEnumName>` variable `YourEnumName.Values.all.

### Creating enum

#### Enum from a literal 

You can still create your `enum` instance as previously, with literal intialization `init?(rawValue:)`:

```swift
let myCase = YourEnumName(rawValue: "case1") // myCase = .caseNo1
```

#### Enum from a String variable

If you cannot use literals (e.g. when you have only `String` instance passed you from somewhere else), you can create it using `init?(raw:)` initializer:

```swift
let someString = "case1"
...
let myCase = YourEnumName(raw: someString) // myCase = .caseNo1
let myOtherCase = YourEnumName(raw: "case1") // myOtherCase = .caseNo1
```

### Enums with `Int` RawValue

`EnumList` works the same when dealing with `Int` rawValues:

```swift
private enum YourIntEnum: EnumListStringRaw<YourIntEnum.Values>, RawRepresentable{
   struct Values:EnumValues {
      typealias Element = YourIntEnum
      static var allRaws:Set<Int> = []
   }
   case caseNo1 = 1
   case caseNo2 = 3
}

YourIntEnum.Values.all // Set([.caseNo1, .caseNo2])
YourIntEnum.Values.allRaws //  Set([1, 2])

let myCase = YourIntEnum(rawValue: 1) // .caseNo1

```

### Enums with "Default" RawValue

Same as with standard `enum`, you don't need to specify all rawValues manually. Compiler will fill it for you, with the same `String` raw values, as a name of a case. You can mix cases with custom/automatic `rawValue`:

```swift
private enum YourEnumName: EnumListStringRaw<YourEnumName.Values>, RawRepresentable{
  struct Values:EnumValues {
    typealias Element = YourEnumName
    static var allRaws:Set<String> = []
  }
  case caseNo1 // is equivalent to case caseNo1 = "caseNo1"
  case caseNo2 = "case2"
}

YourEnumName.Values.all //  Set([.caseNo1, .caseNo2]) 
YourEnumName.Values.allRaws //  Set(["caseNo1", "case2"])

```


### All Raw Values

To can grab all raw values (which are a `Set<String>` or `Set<Int>`, depending of your `enum` deifinition), but keep in mind that you have to either call `YourEnumName.Values.initialize()` or `YourEnumName.Values.all` before that, just to fill `YourEnumName.Values.allRaws` with valid values.

### Safety

Swift does not allow to create several `enum` cases with same literal. It applies also for `EnumList`:

```swift
private enum YourEnumName: EnumListStringRaw<YourEnumName.Values>, RawRepresentable{
  struct Values:EnumValues {
    typealias Element = YourEnumName
    static var allRaws:Set<String> = []
  }
  case caseNo1 = "case1"
  //case caseNo2 = "case1" - compile error: RawValues have to be unique
}
```

### Integration with [Unbox](https://github.com/JohnSundell/Unbox)

If you want use your `enum` with [`Unbox`](https://github.com/JohnSundell/Unbox) framework, include additional subspec, `EnumList/Unbox` to your `Podfile`:

```ruby
target 'TARGET' do
  pod 'EnumList/Core'
  pod 'EnumList/Unbox'
end
```

then by conforming your enum to `UnboxableEnum`, it works out of a box: 

```swift 
private enum EnumForUnbox: EnumListStringRaw<EnumForUnbox.Values>, RawRepresentable, UnboxableEnum{
  struct Values:EnumValues {
    typealias Element = EnumForUnbox
    static var allRaws:Set<String> = []
  }
  case caseNo1 = "case1"
  case caseNo2 = "case2"
}

let dictionary:[String:Any] = ["data":"case1"]
let a = Unboxer(dictionary:dictionary)
let unboxEnum:EnumForUnbox = try a.unbox(key: "data") // .caseNo1
```

## Running the tests

### Xcode 
Library is covered with unit tests: to run tests integrated with `EnumListPoroject.xcodeworkspace` project: install all CocoaPods dependencies (`pod install` in your terminal) and run default unit tests (⌘+U). 

### Fastlane

To test all unit tests from a commandline, call 'fastlane test' in the `Project` directory.

## Deployment

Use `fastlane` to build a project: [fastlane Readme](Project/fastlane/)

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/polac24/EnumList/tags). 

## Authors

* **Bartosz Polaczyk** - [polac24](https://github.com/polac24)

See also the list of [contributors](https://github.com/polac24/EnumList/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details



[swift-badge]: https://img.shields.io/badge/Swift-3.1-orange.svg?style=flat
[swift-url]: https://swift.org

[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license

[build-badge]: https://img.shields.io/travis/polac24/EnumList.svg?maxAge=0
[build-url]: https://travis-ci.org/polac24/EnumList

[codecov-badge]: https://img.shields.io/coveralls/polac24/EnumList.svg?maxAge=0
[codecov-url]: https://coveralls.io/github/polac24/EnumList

[fastlane-badge]: https://img.shields.io/badge/fastlane-2.35.1-yellow.svg
[fastlane-url]: Project/fastlane/Fastfile

[cocoapods-badge]: https://img.shields.io/cocoapods/v/EnumList.svg?maxAge=0
[cocoapods-url]: https://cocoapods.org/pods/EnumList

[cocoapods-platform-badge]: https://img.shields.io/cocoapods/p/EnumList.svg?maxAge=0
[cocoapods-platform-url]: https://cocoapods.org/pods/EnumList
