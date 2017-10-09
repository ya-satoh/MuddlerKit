//
//  Extension.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2017/06/05.
//  Copyright © 2017年 Kosuke Matsuda. All rights reserved.
//

import Foundation

/**
 http://qiita.com/motokiee/items/e8f07c11b88d692b2cc5
 */
public struct Extension<Base> {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible

    static var mk: Extension<Compatible>.Type { get set }

    var mk: Extension<Compatible> { get set }
}

extension ExtensionCompatible {
    public static var mk: Extension<Self>.Type {
        get {
            return Extension<Self>.self
        }
        set {
            // this enables using Extension to "mutate" base type
        }
    }

    public var mk: Extension<Self> {
        get {
            return Extension(self)
        }
        set {
            // this enables using Extension to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `mk` proxy.
extension NSObject: ExtensionCompatible { }
