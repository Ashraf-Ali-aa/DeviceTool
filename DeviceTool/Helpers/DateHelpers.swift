//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

extension Date {
    func toFilenameString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "ddMMyyyy-HHmmss"

        return dateFormatter.string(from: self)
    }
}
