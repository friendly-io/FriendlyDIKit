//
//  Resolver.swift
//  FriendlyDI
//
//  Created by spsadmin on 1/23/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

public protocol Resolver: class {
    func require<Service>(_ type: Service.Type, tag: String?) -> Service?
}

public extension Resolver {
    func require<Service>(_ type: Service.Type) -> Service? {
        return require(type, tag: nil)
    }
}
