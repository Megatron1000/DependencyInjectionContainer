//
//  DependencyContainer.swift
//  DependencyInjectionContainer
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import Foundation

public final class DependencyContainer {
        
    private var dependencies = [DefinitionKey : ()->Any]()
    
    public init(){}
    
    public func register<T>(factory: @escaping ()->T) {
        let key = DefinitionKey(type: T.self)
        dependencies[key] = factory
    }
    
    /// Locking the resolve function in order to detect infinite recurssion
    private var isResolveLocked = false
    
    public func resolve<T>() -> T {
        precondition(isResolveLocked == false, "Circular reference found resolving \(T.self). Use LazilyResolvedPropertyWrapper on one of the objects.")
        isResolveLocked = true
        let key = DefinitionKey(type: T.self)
        guard let factory = self.dependencies[key]?() as? T else {
            preconditionFailure("Unable to resolve instance for \(key)")
        }
        isResolveLocked = false
        return factory
    }

}
