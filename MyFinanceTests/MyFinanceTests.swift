//
//  MyFinanceTests.swift
//  MyFinanceTests
//
//  Created by Kevin on 3/24/24.
//

import XCTest
@testable import MyFinance

final class MyFinanceTests: XCTestCase {

    var sut: FinanceViewModel!

    override func setUp() {
        super.setUp()
        sut = .init()
    }

    override  func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testPerformCaculateInterestRate() {
        sut.calculateInterestAmount(
            amount: "20000",
            interestRate: "6",
            duration: "2.5"
        )
        XCTAssertEqual(sut.result, "3,000")
    }

    func testExeptionCaculateInterestRate() {
        sut.calculateInterestAmount(
            amount: "10000",
            interestRate: "5.1",
            duration: "1"
        ) // Expected interest: 1200.00
        XCTAssertEqual(sut.result, "51,000")
    }


}
