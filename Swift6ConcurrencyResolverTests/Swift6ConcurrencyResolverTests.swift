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
        let object = StronglyHoldingParameterHolder()
        await object.dispatchStronglyHoldingParameter("Not nil")

        XCTAssert(object.value == "Not nil")
    }
}

private class StronglyHoldingParameterHolder {
    var value: String?

    init() { }

    func dispatchStronglyHoldingParameter(_ value: String) async {
        var optionalValue: String?
        optionalValue = value
        guard let nonOptionalValue = optionalValue else { return }

        await stronglyHoldingParameter(nonOptionalValue)
    }

    private func stronglyHoldingParameter(_ value: String) async {
        await setValue(value)
    }

    @MainActor
    private func setValue(_ value: String?) {
        self.value = value
    }
}
