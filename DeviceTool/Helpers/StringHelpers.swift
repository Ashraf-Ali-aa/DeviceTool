//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

extension String {
    func toFilenameString() -> String {
        return lowercased()
            .replacingOccurrences(of: " ", with: "-")
    }
}
