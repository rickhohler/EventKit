import Foundation
import Testing

@testable import EventKit

@Test func testEventDateWithTimestamp() async throws {
    let builder = EventDateBuilder()
    let now = Date()
    let eventDate =
        try builder
        .addAccuracy(.exact, timestamp: now)
        .build()

    let start = eventDate?.start

    #expect(start != nil)
    #expect(eventDate?.start! == now)
    #expect(eventDate?.end! == now)
    #expect(eventDate?.level == DateComponentLevel.timestamp)
}

@Test func testEventDateWithApproximateYear() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == nil)
    #expect(eventDate?.day == nil)
    #expect(eventDate?.hour == nil)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.years)
}

@Test func testEventDateWithApproximateMonth() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023, month: 10)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == nil)
    #expect(eventDate?.hour == nil)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.months)
}

@Test func testEventDateWithApproximateDay() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023, month: 10, day: 5)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == nil)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.days)
}

@Test func testEventDateWithApproximateHour() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023, month: 10, day: 5, hour: 14)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == 14)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.hours)
}

@Test func testEventDateWithApproximateMinute() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023, month: 10, day: 5, hour: 14, minute: 3)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == 14)
    #expect(eventDate?.minute == 3)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.minutes)
}

@Test func testEventDateWithApproximateSecond() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(year: 2023, month: 10, day: 5, hour: 14, minute: 3, second: 30)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == 14)
    #expect(eventDate?.minute == 3)
    #expect(eventDate?.second == 30)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.seconds)
}

@Test func testEventDateWithApproximateMillisecond() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.approximate)
        .addComponents(
            year: 2023, month: 10, day: 5, hour: 14, minute: 3, second: 30, millisecond: 20
        )
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.approximate)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 10)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == 14)
    #expect(eventDate?.minute == 3)
    #expect(eventDate?.second == 30)
    #expect(eventDate?.millisecond == 20)
    #expect(eventDate?.level == DateComponentLevel.milliseconds)
}

@Test func testEventDateWithEstimatedNone1() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.estimated)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.estimated)
    #expect(eventDate?.year == nil)
    #expect(eventDate?.month == nil)
    #expect(eventDate?.day == nil)
    #expect(eventDate?.hour == nil)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.none)
}

@Test func testEventDateWithEstimatedNone2() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.estimated)
        .addComponents(day: 5, hour: 12)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.estimated)
    #expect(eventDate?.year == nil)
    #expect(eventDate?.month == nil)
    #expect(eventDate?.day == 5)
    #expect(eventDate?.hour == 12)
    #expect(eventDate?.minute == nil)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == nil)
    #expect(eventDate?.level == DateComponentLevel.none)
}

@Test func testEventDateWithEstimatedNone3() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.estimated)
        .addComponents(month: 5, minute: 12, millisecond: 30)
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.estimated)
    #expect(eventDate?.year == nil)
    #expect(eventDate?.month == 5)
    #expect(eventDate?.day == nil)
    #expect(eventDate?.hour == nil)
    #expect(eventDate?.minute == 12)
    #expect(eventDate?.second == nil)
    #expect(eventDate?.millisecond == 30)
    #expect(eventDate?.level == DateComponentLevel.none)
}

@Test func testEventDateWithEstimatedMillisecond() async throws {
    let builder = EventDateBuilder()
    let eventDate =
        try builder
        .addAccuracy(.estimated)
        .addComponents(
            year: 2023,
            month: 5,
            day: 12,
            hour: 14,
            minute: 3,
            second: 30,
            millisecond: 20
        )
        .build()

    #expect(eventDate?.accuracy == DateAccuracy.estimated)
    #expect(eventDate?.year == 2023)
    #expect(eventDate?.month == 5)
    #expect(eventDate?.day == 12)
    #expect(eventDate?.hour == 14)
    #expect(eventDate?.minute == 3)
    #expect(eventDate?.second == 30)
    #expect(eventDate?.millisecond == 20)
    #expect(eventDate?.level == DateComponentLevel.milliseconds)
}
