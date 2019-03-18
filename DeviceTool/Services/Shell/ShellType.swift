//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

protocol ShellType {
    @discardableResult
    func execute(_ command: String) -> (output: [String], error: [String], exitCode: Int32)
}
