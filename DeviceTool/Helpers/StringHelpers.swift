//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

extension String {
    func toFilenameString() -> String {
        return lowercased()
            .replacingOccurrences(of: " ", with: "-")
    }
}
