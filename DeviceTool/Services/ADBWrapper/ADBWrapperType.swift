//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

protocol ADBWrapperType {
    init(shell: ShellType, platformToolsPath: String)

    func listDeviceIds() -> [String]
    func getDevice(forId identifier: String) -> Device

    func reboot(to: ADBRebootType, identifier: String)

    func takeScreenshot(identifier: String, path: String)

    func pull(identifier: String, fromPath: String, toPath: String)
    func remove(identifier: String, path: String)

    func wakeUpDevice(identifier: String)
    func installAPK(identifier: String, fromPath path: String)
}
