//
//  Swift6ConcurrencyResolverTests.swift
//  Swift6ConcurrencyResolverTests
//
//  Created by Kamaal M Farah on 17/08/2024.
//

import XCTest

final class Swift6ConcurrencyResolverTests: XCTestCase {
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testStronglyTransferedParameter() async throws {
        let object = StronglyHoldingParameterHolder(newValue: "Not nil")
        try await Task.sleep(nanoseconds: 3_000_000_000)

        XCTAssert(object.value == "Not nil")
    }
}

private class StronglyHoldingParameterHolder {
    var value: String?

    init(newValue: String) {
        var optionalValue: String?
        optionalValue = newValue
        guard let nonOptionalValue = optionalValue else { return }

        Task {
            await noParamer()
            await stronglyHoldingParameter(nonOptionalValue)
        }
    }

    private func noParamer() async { }

    private func stronglyHoldingParameter(_ nonOptionalValue: String) async {
        value = nonOptionalValue
    }
}

private func stronglyHoldingParameter(_ nonOptionalValue: String) async { }
