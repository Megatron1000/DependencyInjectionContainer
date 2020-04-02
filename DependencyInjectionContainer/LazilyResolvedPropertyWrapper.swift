//
//  LazilyResolvedPropertyWrapper.swift
//  DependencyInjectionContainer
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import Foundation

final public class LazilyResolvedPropertyWrapper<T> {
    
    weak private var dependencyContainer: DependencyContainer?
    
    init(dependencyContainer: DependencyContainer?) {
        self.dependencyContainer = dependencyContainer
    }
    
    var value: T {
        if let previouslyResolvedValue = previouslyResolvedValue {
            return previouslyResolvedValue
        }
        guard let dependencyContainer = self.dependencyContainer else {
            preconditionFailure("DependencyContainer has been deallocated")
        }
        let resolvedValue = dependencyContainer.resolve() as T
        previouslyResolvedValue = resolvedValue
        return resolvedValue
    }
    
    private var previouslyResolvedValue: T?
}
