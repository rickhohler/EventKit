# EventKit

Swift package for data event related data types.

## Installation

### Swift Package Manager

Add the line below to the dependencies section in the Package.swift file:

```swift
.package(url: "https://github.com/rickhohler/EventKit.git", from: "1.0.0")
```

Add the product "EventKit" as a dependency target:

```swift
.product(name: "EventKit", package: "EventKit"),
```

## Types

### EventDate

A structure that represents an event date, including the level of detail captured (such as year, month, day, minute, second, or millisecond). It also includes an accuracy attribute that indicates how precise or reliable the recorded date is.
