//
//  ServiceEntry.swift
//  FriendlyDI
//
//  Created by spsadmin on 1/23/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

protocol FactoryProtocol { }

class CachingFactory<T>: FactoryProtocol {
    let factory: (Resolver) -> Factored<T>
    var cachedInstance: T?
    init(factory: @escaping (Resolver) -> Factored<T>) {
        self.factory = factory
    }
}
