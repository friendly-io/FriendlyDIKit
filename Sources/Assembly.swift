//
//  Assembly.swift
//  FriendlyDI
//
//  Created by spsadmin on 3/25/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

public protocol Assembly {
    func assemble(container: Container)
    func doneAssembling(resolver: Resolver)
}
