//
//  DependencyContainerTests.swift
//  DependencyInjectionContainerTests
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import XCTest
@testable import DependencyInjectionContainer

final class DependencyInjectionContainerTests: XCTestCase {

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
        let dependencyContainer = DependencyContainer()
        dependencyContainer.register { RealService() as Service }
        
        dependencyContainer.register { MockService() as Service }

        let service: Service = dependencyContainer.resolve()
        XCTAssert(service is MockService)
    }
    
    func testCircularDependency() {
        let dependencyContainer = DependencyContainer()
        dependencyContainer.register { ServiceClient(service: LazilyResolvedPropertyWrapper<Service>(dependencyContainer: dependencyContainer)) as Client }
        dependencyContainer.register { ClientService(client: dependencyContainer.resolve()) as Service }

        let service: Service = dependencyContainer.resolve()
        let client: Client = dependencyContainer.resolve()
        
        let clientService = service as? ClientService
        let serviceClient = client as? ServiceClient
        
        XCTAssertNotNil(clientService)
        XCTAssertNotNil(serviceClient)

        XCTAssert(clientService?.client is ServiceClient)
        XCTAssert(serviceClient?.service.value is ClientService)
    }
    
}


// MARK: Service Stubs

protocol Service: class {}

class RealService: Service {}

class MockService: Service {}


// MARK: Client Stubs

protocol Client: class {}

class RealClient: Client {}

class MockClient: Client {}


// MARK: Circular Dependency Stubs

class ClientService: Service {
    var client: Client
    init(client: Client) {
        self.client = client
    }
}

class ServiceClient: Client {
    var service: LazilyResolvedPropertyWrapper<Service>
    init(service: LazilyResolvedPropertyWrapper<Service>) {
        self.service = service
    }
}
