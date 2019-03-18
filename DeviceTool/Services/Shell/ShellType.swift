//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

protocol ShellType {
    @discardableResult
    func execute(_ command: String) -> (output: [String], error: [String], exitCode: Int32)
}
