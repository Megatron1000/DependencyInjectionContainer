//
//  DependencyContainer.swift
//  DependencyInjectionContainer
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import Foundation

/// Very basic IoC Implementation
/// Notable ommissions include:
/// LifeCycle options i.e. singletons rather than everything being transient
/// Runtime arguments
public final class DependencyContainer {
        
    private var dependencies = [DefinitionKey : ()->Any]()
    
    public init(){}
    
    /// Provide a constructor to be used whenever an instance of T is resolved
    /// - Parameter factory: The constructor
    ///
    /// ```swift
    /// dependencyContainer.register {
    ///    DefaultExampleService() as ExampleService
    /// }
    /// ```
    public func register<T>(factory: @escaping ()->T) {
        let key = DefinitionKey(type: T.self)
        dependencies[key] = factory
    }
        
    /// Resolve an instance of type `T`.
    /// - Returns: An instance of type `T`.
    ///
    /// ```swift
    /// let service: Service = dependencyContainer.resolve()
    /// ```
    public func resolve<T>() -> T {
        precondition(isResolveLocked == false, "Circular reference found resolving \(T.self). Use LazilyResolvedPropertyWrapper on one of the objects to break this.")
        isResolveLocked = true
        let key = DefinitionKey(type: T.self)
        guard let factory = self.dependencies[key]?() as? T else {
            preconditionFailure("Unable to resolve instance for \(key)")
        }
        isResolveLocked = false
        return factory
    }

    /// Locking the resolve function in order to detect infinite recursion
    private var isResolveLocked = false
}
