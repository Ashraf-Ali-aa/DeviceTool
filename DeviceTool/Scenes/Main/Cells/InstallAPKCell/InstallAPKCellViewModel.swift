//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class InstallAPKCellViewModel: ActionCellViewModel {}

extension InstallAPKCellViewModel: InstallAPKCellViewModelType {
    public func installAPK(atURL URL: NSURL) {
        guard
            let platform = currentDevice?.platform,
            let identifier = currentDevice?.identifier,
            let path = URL.path,
            let pathExtension = URL.pathExtension
        else {
            return
        }

        if platform == .android && pathExtension != "apk" ||
            platform == .ios && pathExtension != "ipa" {
            print("File not supported")
            return
        }

        deviceInterface?.installApplication(identifier: identifier, fromPath: path)
    }
}
