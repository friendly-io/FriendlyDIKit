//
//  Container.swift
//  FriendlyDI
//
//  Created by spsadmin on 1/23/18.
//  Copyright © 2018 Friendly App Studio. All rights reserved.
//

import Foundation

public enum Factored<T> {
    case cacheable(T)
    case transient(T)
    case fail(Error?)
}

public protocol Scoping {
    var container: Container { get }
    func scoped<T>(_ value: T?) -> Factored<T>
}

public class BaseScope {
    public let container: Container
    init(container: Container) {
        self.container = container
    }
}
class ContainerScope: BaseScope, Scoping {
    public func scoped<T>(_ value: T?) -> Factored<T> {
        guard let value = value else { return .fail(nil) }
        return .cacheable(value)
    }
}
class TransientScope: BaseScope, Scoping {
    func scoped<T>(_ value: T?) -> Factored<T> {
        guard let value = value else { return .fail(nil) }
        return .transient(value)
    }
}
extension Scoping {
    public func given<A>(_ getter: @escaping (Resolver) -> A?) -> RequirementValue<A> {
        return RequirementValue<A>(scope: self, getter: getter)
    }
    public func given<A>(_ type: A.Type, tag: String? = nil ) -> RequirementValue<A> {
        return given { resolver in return resolver.require(A.self, tag: tag) }
    }
    @discardableResult
    public func define<T>(_ type: T.Type, tag: String? = nil, factory: @escaping (Resolver) -> T?) -> Self {
        container.factories[FactoryKey(factoryType: type, tag: tag)] = CachingFactory(factory: { resolver in return self.scoped(factory(resolver)) })
        return self
    }
}

public class Container {
    fileprivate var factories: [FactoryKey: FactoryProtocol] = [:]
    private var log: (String) -> Void
    
    public var transientScope: Scoping {
        return TransientScope(container: self)
    }
    public var containerScope: Scoping {
        return ContainerScope(container: self)
    }
    
    public init(log: @escaping (String) -> Void = { msg in NSLog("%@",msg) }) {
        self.log = log
    }
}

extension Container: Resolver {
    public func require<T>(_ type: T.Type, tag: String? = nil) -> T? {
        let key = FactoryKey(factoryType: type, tag: tag)
        guard let entry = factories[key] as? CachingFactory<T> else {
            log("No factory for key: \(key)")
            return nil
        }
        if let instance = entry.cachedInstance {
            return instance
        }
        let factored = entry.factory(self)
        switch factored {
        case let .cacheable(s):
            log("Cached Instance of type [\(type)] \(tag ?? "")")
            entry.cachedInstance = s
            return s
        case let .transient(s):
            log("Transient instance of type [\(type)] \(tag ?? "")")
            return s
        case let .fail(error):
            log("Fail to resolve \(type) \(tag ?? "") : \(error?.localizedDescription ?? "unknown error")")
            return nil
        }
    }
}
