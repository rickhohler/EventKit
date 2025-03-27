import Foundation

/// An enumeration representing the different levels of date components.
/// This can be used to specify the granularity of a date component, such as year, month, day, etc.
public enum DateComponentLevel {
    case timestamp
    case milliseconds
    case seconds
    case minutes
    case hours
    case days
    case weeks
    case months
    case years
    case none
}

/// An enumeration representing the accuracy of a date.
///
/// This enum is used to specify the level of level for a given date.
///
/// - Note: Ensure to select the appropriate accuracy level based on the context
/// in which the date is being used.
public enum DateAccuracy {
    case exact
    case approximate
    case estimated
}

/// A structure representing an event date.
///
/// This structure is used to encapsulate the date information for an event.
public struct EventDate {
    let level: DateComponentLevel
    let accuracy: DateAccuracy
    let timestamp: Date?
    let year: Int?
    let month: Int?
    let day: Int?
    let hour: Int?
    let minute: Int?
    let second: Int?
    let millisecond: Int?

    /// Initializes a new instance of the EventDate class.
    ///
    /// - Throws: An error advising the user to use the EventDateBuilder class instead.
    public init() throws {
        throw EventDateBuilderError.initUseEventDateBuilder
    }

    fileprivate init(
        level: DateComponentLevel, accuracy: DateAccuracy, timestamp: Date?, year: Int?,
        month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?, millisecond: Int?
    ) {
        self.level = level
        self.accuracy = accuracy
        self.timestamp = timestamp
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
    }

    var start: Date? {
        if accuracy == .exact {
            return timestamp
        } else {
            switch level {
            case .timestamp:
                return nil
            case .none:
                return nil
            case .years:
                return DateComponents(
                    calendar: .current, year: year!
                ).date
            case .months:
                return DateComponents(
                    calendar: .current, year: year!, month: month!
                ).date
            case .weeks:
                return DateComponents(
                    calendar: .current, year: year!, month: month!, day: day!
                ).date
            case .days:
                return DateComponents(
                    calendar: .current, year: year!, month: month!, day: day!
                ).date
            case .hours:
                return DateComponents(
                    calendar: .current, year: year!, month: month!, day: day!, hour: hour!
                ).date
            case .minutes:
                return DateComponents(
                    calendar: .current, year: year!, month: month!, day: day!, hour: hour!,
                    minute: minute!
                ).date
            case .seconds:
                return DateComponents(
                    calendar: .current, year: year!, month: month!, day: day!, hour: hour!,
                    minute: minute!, second: second!
                ).date
            case .milliseconds:
                return DateComponents(
                    calendar: .current, year: year, month: month, day: day!, hour: hour,
                    minute: minute,
                    second: second, nanosecond: millisecond == nil ? nil : millisecond! * 1_000_000
                ).date
            }
        }
    }

    var end: Date? {
        return timestamp ?? DateComponents(
            calendar: .current, year: year, month: month, day: day, hour: hour, minute: minute,
            second: second, nanosecond: millisecond == nil ? nil : millisecond! * 1_000_000
        ).date!
    }

}

/// An enumeration representing errors that can occur while building an `EventDate`.
///
/// - Note: This error type is used to indicate various failure conditions that might
///         arise during the construction of an `EventDate` object.
enum EventDateBuilderError: Error {
    case initUseEventDateBuilder
    case missingAccuracy
    case exactRequiresTimestamp
}

/// A builder class for creating and configuring `EventDate` instances.
///
/// This class provides a fluent interface for setting various properties
/// of an `EventDate` object, allowing for easy and readable construction
/// of event dates.
///
/// Example usage:
/// ```swift
/// let eventDate = EventDateBuilder()
///     .setYear(2023)
///     .setMonth(10)
///     .setDay(25)
///     .build()
/// ```
///
/// - Note: This class is part of the EventKit module.
public class EventDateBuilder {
    var accuracy: DateAccuracy?
    var timestamp: Date?
    var year: Int?
    var month: Int?
    var day: Int?
    var hour: Int?
    var minute: Int?
    var second: Int?
    var millisecond: Int?

    /// Adds the specified accuracy to the event date.
    ///
    /// - Parameters:
    ///   - accuracy: The accuracy to be added to the event date.
    ///   - timestamp: An optional timestamp to be used. If not provided, the current date and time will be used.
    /// - Returns: The updated event date with the specified accuracy added.
    /// - Throws: An error if the accuracy cannot be added.
    func addAccuracy(_ accuracy: DateAccuracy, timestamp: Date? = nil) throws -> Self {
        if accuracy == .exact {
            guard timestamp != nil else {
                throw EventDateBuilderError.exactRequiresTimestamp
            }
            self.timestamp = timestamp!
        }
        self.accuracy = accuracy
        return self
    }

    /// Adds the specified date components to the current date.
    ///
    /// - Parameter components: The date components to add.
    /// - Returns: A new date with the added components.
    /// - Throws: An error if the date components could not be added.
    func addComponents(
        year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil,
        second: Int? = nil, millisecond: Int? = nil
    ) -> Self {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.millisecond = millisecond
        return self
    }

    /// Builds and returns an `EventDate` instance.
    ///
    /// - Throws: An error if the `EventDate` instance could not be built.
    /// - Returns: An optional `EventDate` instance. Returns `nil` if the `EventDate` could not be built.
    func build() throws -> EventDate? {
        guard let accuracy = accuracy else {
            throw EventDateBuilderError.missingAccuracy
        }
        let level: DateComponentLevel =
            switch accuracy {
            case .exact:
                DateComponentLevel.timestamp
            case .approximate, .estimated:
                determineLevel()
            }
        return EventDate(
            level: level,
            accuracy: accuracy,
            timestamp: timestamp,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second,
            millisecond: millisecond
        )
    }

    /// Determines the level of the date component.
    ///
    /// - Returns: A `DateComponentLevel` representing the level of the date component.
    private func determineLevel() -> DateComponentLevel {
        if emptyValue(year) {
            return .none
        } else if emptyValue(month) {
            return .years
        } else if emptyValue(day) {
            return .months
        } else if emptyValue(hour) {
            return .days
        } else if emptyValue(minute) {
            return .hours
        } else if emptyValue(second) {
            return .minutes
        } else if emptyValue(millisecond) {
            return .seconds
        }
        return .milliseconds
    }

    /// Checks if the given optional integer value is nil or not.
    ///
    /// - Parameter value: An optional integer value to check.
    /// - Returns: `true` if the value is nil, otherwise `false`.
    private func emptyValue(_ value: Int?) -> Bool {
        if let value = value, value != 0 {
            return false
        }
        return true
    }
}
