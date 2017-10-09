//
//  StringExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import Foundation

// MARK: - deviceToken

extension String {
    // http://stackoverflow.com/a/24979960
    public init?(deviceToken: Data) {
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        (0..<deviceToken.count).indices.forEach { (i) in
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        self = tokenString
    }
}


extension String: ExtensionCompatible {}
extension Extension where Base == String {
    // https://github.com/omaralbeik/SwifterSwift/blob/master/Extensions/StringExtensions.swift
    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    public func camelCased(_ startIsUpper: Bool = false) -> String {
        guard !base.isEmpty else { return base }
        let source = base
        if source.characters.contains(" ") {
            let first = String(source.prefix(upTo: source.index(source.startIndex, offsetBy: 1)))
            let camel = source.capitalized.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.characters.dropFirst())
            return "\(startIsUpper ? first.uppercased() : first)\(rest)"
        } else {
            let first = String(source.lowercased().prefix(upTo: source.index(source.startIndex, offsetBy: 1)))
            let rest = String(source.characters.dropFirst())
            return "\(startIsUpper ? first.uppercased() : first)\(rest)"
        }
    }

    public func pascalCased() -> String {
        return camelCased(true)
    }

    // http://uyama.coffee/wp/swift3xcode8でランダムな文字列を取得する/
    public static func randomAlphanumericString(_ length: Int) -> String {
        let alphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = UInt32(alphabet.characters.count)
        return String((0..<length).map { _ -> Character in
            return alphabet[alphabet.index(alphabet.startIndex, offsetBy: Int(arc4random_uniform(upperBound)))]
        })
    }

    public static func repeatedString(text: String, length: UInt32, isNotEmpty: Bool = true) -> String {
        let random = arc4random_uniform(length) + (isNotEmpty ? 1 : 0)
        return (0..<random).reduce("") { (result, value) in
            var result = result
            result += text
            return result
        }
    }
}
