//
//  Requirements.swift
//  FriendlyDI
//
//  Created by spsadmin on 2/20/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

public class Requirement {
    let scope: Scoping
    init(scope: Scoping) {
        self.scope = scope
    }
}

public class RequirementValue<A>: Requirement {
    private let getter: (Resolver) -> A?
    init(scope: Scoping,  getter: @escaping (Resolver) -> A?) {
        self.getter = getter
        super.init(scope: scope)
    }
    @discardableResult
    public func define<T>(_ type: T.Type, tag:String? = nil, factory: @escaping (A,Resolver) -> T?) -> Scoping {
        let getter = self.getter
        return scope.define(type, tag: tag) { resolver in
            guard let a = getter(resolver) else { return nil }
            return factory(a, resolver)
        }
    }
    public func given<B>(_ getter: @escaping (Resolver) -> B?) -> RequirementValue<(A,B)> {
        let getterForA = self.getter
        return RequirementValue<(A,B)>(scope: scope, getter: { resolver in
            guard let a = getterForA(resolver) else { return nil }
            guard let b = getter(resolver) else { return nil }
            return (a,b)
        })
    }
    public func given<B>(_ type: B.Type, tag: String? = nil) -> RequirementValue<(A,B)> {
        return given { resolver in return resolver.require(B.self, tag: tag) }
    }
}

extension RequirementValue {
    @discardableResult
    public func define<T,B,C>(_ type: T.Type, tag:String? = nil, factory: @escaping (B,C,Resolver) -> T?) -> Scoping where A == (B,C) {
        return define(type, tag: tag, factory: { (tupple, resolver) in
            return factory(tupple.0, tupple.1, resolver)
        })
    }
    @discardableResult
    public func define<T,B,C,D>(_ type: T.Type, tag:String? = nil, factory: @escaping (B,C,D,Resolver) -> T?) -> Scoping where A == ((B,C),D) {
        return define(type, tag: tag, factory: { (tupple, resolver) in
            return factory(tupple.0.0, tupple.0.1, tupple.1, resolver)
        })
    }
    @discardableResult
    public func define<T,B,C,D,E>(_ type: T.Type, tag:String? = nil, factory: @escaping (B,C,D,E,Resolver) -> T?) -> Scoping where A == (((B,C),D),E) {
        return define(type, tag: tag, factory: { (tupple, resolver) in
            return factory(tupple.0.0.0, tupple.0.0.1, tupple.0.1, tupple.1, resolver)
        })
    }
    @discardableResult
    public func define<T,B,C,D,E,F>(_ type: T.Type, tag:String? = nil, factory: @escaping (B,C,D,E,F,Resolver) -> T?) -> Scoping where A == ((((B,C),D),E),F) {
        return define(type, tag: tag, factory: { (tupple, resolver) in
            return factory(tupple.0.0.0.0, tupple.0.0.0.1, tupple.0.0.1, tupple.0.1, tupple.1, resolver)
        })
    }
    @discardableResult
    public func define<T,B,C,D,E,F,G>(_ type: T.Type, tag:String? = nil, factory: @escaping (B,C,D,E,F,G,Resolver) -> T?) -> Scoping where A == (((((B,C),D),E),F),G) {
        return define(type, tag: tag, factory: { (tupple, resolver) in
            return factory(tupple.0.0.0.0.0, tupple.0.0.0.0.1, tupple.0.0.0.1, tupple.0.0.1, tupple.0.1, tupple.1, resolver)
        })
    }
}
