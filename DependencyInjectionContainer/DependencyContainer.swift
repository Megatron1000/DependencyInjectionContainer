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
    
    public func resolve<T>() -> T {
        let key = DefinitionKey(type: T.self)
        guard let factory = self.dependencies[key]?() as? T else {
            preconditionFailure("Unable to resolve instance for \(key)")
        }
        return factory
    }

}
