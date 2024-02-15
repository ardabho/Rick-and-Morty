//
//  DateFormatterTests.swift
//  RickAndMortyTests
//
//  Created by ARDA BUYUKHATIPOGLU on 15.02.2024.
//

import XCTest
@testable import RickAndMorty

final class DateFormatterTests: XCTestCase {
    
    func testFormatDateFromISOToString() {
        // Given
        let isoDateString = "2024-02-15T08:30:00.000Z"
        let expectedFormattedString = "Feb 15, 2024"
        
        // When
        let formattedString = isoDateString.formatDateFromISOToString()
        
        // Then
        XCTAssertEqual(formattedString, expectedFormattedString, "Formatted string should match expected format")
    }
    
    func testFormatDateFromISOToStringWithInvalidInput() {
        // Given
        let invalidIsoDateString = "InvalidDate"
        
        // When
        let formattedString = invalidIsoDateString.formatDateFromISOToString()
        
        // Then
        XCTAssertNil(formattedString, "Formatted string should be nil for invalid input")
    }
    
}
