//
//  Assembler.swift
//  FriendlyDI
//
//  Created by spsadmin on 3/25/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

public final class Assembler {
    private let container: Container
    public var resolver: Resolver { return container }
    
    public init(withAssemblies assemblies: [Assembly], log: @escaping (String) -> Void = { msg in NSLog("%@",msg) }) {
        self.container = Container(log: log)
        run(assemblies: assemblies)
    }
    
    public func run(assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: self.container) }
        assemblies.forEach { $0.doneAssembling(resolver: self.container) }
    }
}
