//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

final class InstallAPKCellViewModel: ActionCellViewModel {}

extension InstallAPKCellViewModel: InstallAPKCellViewModelType {
    public func installAPK(atURL URL: NSURL) {
        guard
            let identifier = currentDevice?.identifier,
            let path = URL.path
        else {
            return
        }

        adbWrapper.installAPK(identifier: identifier, fromPath: path)
    }
}
