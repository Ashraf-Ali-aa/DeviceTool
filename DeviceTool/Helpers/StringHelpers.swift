//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

extension String {
    func toFilenameString() -> String {
        return lowercased()
            .components(separatedBy: .whitespacesAndNewlines)
            .flatMap { $0.components(separatedBy: .punctuationCharacters) }
            .filter { !$0.isEmpty }
            .joined(separator: "_")
    }

    func trim() -> String {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
