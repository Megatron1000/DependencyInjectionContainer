//
//  DependencyContainerTests.swift
//  DependencyInjectionContainerTests
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import XCTest
@testable import DependencyInjectionContainer

class DependencyInjectionContainerTests: XCTestCase {

    func testRegisterThenResolve() {
        let dependencyContainer = DependencyContainer()
        dependencyContainer.register { RealService() as Service }
        dependencyContainer.register { RealClient() as Client }
        
        let service: Service = dependencyContainer.resolve()
        let client: Client = dependencyContainer.resolve()

        XCTAssert(service is RealService)
        XCTAssert(client is RealClient)
    }

    func testRegisteringOverwritesPreviousRegistration() {

    }

}

protocol Service {}

class RealService: Service {}

class MockService: Service {}


protocol Client {}

class RealClient: Client {}

class MockClient: Client {}
