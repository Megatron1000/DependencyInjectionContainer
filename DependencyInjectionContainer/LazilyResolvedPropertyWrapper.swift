//
//  LazilyResolvedPropertyWrapper.swift
//  DependencyInjectionContainer
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import Foundation

/// Use this class to when you find yourself in a situations where ClassA depends on ClassB and ClassB also depends on ClassA.
/// This defers `resolve()` being called until the first access of the `value`. Preventing the infinite recursion you'd otherwise encounter
final public class LazilyResolvedPropertyWrapper<T> {

    weak private var dependencyContainer: DependencyContainer?

    /// Init
    /// - Parameter dependencyContainer: The app's central DependencyContainer
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    /// The value that resolves as `T` using the `DependencyContainer`
    var value: T {
        // We only want to resolve once.
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
