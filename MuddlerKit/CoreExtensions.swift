//
//  CoreExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import Foundation

// MARK: - Sequence
public extension Sequence {
    // http://stackoverflow.com/a/33795713/226791
    func find(predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self.Iterator.Element? {
        for element in self {
            if try predicate(element) {
                return element
            }
        }
        return nil
    }
}


// MARK: - Int
public extension Int {
    var isNotZero: Bool {
        return self != 0
    }

    var isPositive: Bool {
        return self > 0
    }

    var isNegative: Bool {
        return self < 0
    }
}
