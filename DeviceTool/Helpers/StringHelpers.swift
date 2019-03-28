//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

extension String {
    func toFilenameString() -> String {
        return lowercased()
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: ",", with: "-")
    }

    func trim() -> String {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
