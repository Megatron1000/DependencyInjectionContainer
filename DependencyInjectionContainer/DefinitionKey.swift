//
//  DefinitionKey.swift
//  DependencyInjectionContainer
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import Foundation

struct DefinitionKey: Hashable {

    let type: Any.Type

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
    }

    static func ==(lhs: DefinitionKey, rhs: DefinitionKey) -> Bool {
        return lhs.type == rhs.type
    }

}
