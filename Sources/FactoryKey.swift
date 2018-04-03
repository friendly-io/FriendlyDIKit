//
//  ServiceKey.swift
//  FriendlyDI
//
//  Created by spsadmin on 1/23/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

typealias FactoryType = Any

struct FactoryKey {
    let factoryType: FactoryType.Type
    let tag: String?
    init(factoryType: FactoryType.Type, tag: String? = nil) {
        self.factoryType = factoryType
        self.tag = tag
    }
}

extension FactoryKey: Hashable {
    var hashValue: Int {
        return ObjectIdentifier(factoryType).hashValue ^ (tag?.hashValue ?? 0)
    }
    static func == (lhs: FactoryKey, rhs: FactoryKey) -> Bool {
        return lhs.factoryType == rhs.factoryType
            && lhs.tag == rhs.tag
    }
}
