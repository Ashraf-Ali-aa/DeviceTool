//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

final class ADBWrapperMock: ADBWrapperType {
    init(shell _: ShellType, platformToolsPath _: String) {}

    func listDeviceIds() -> [String] {
        return ["phone", "tablet", "watch", "tv", "auto"]
    }

    func getDevice(forId identifier: String) -> Device {
        return Device(identifier: identifier, properties: [
            "ro.product.model": identifier,
            "ro.build.characteristics": identifier,
        ])
    }

    public func reboot(to _: ADBRebootType, identifier _: String) {}

    func takeScreenshot(identifier _: String, path _: String) {}

    func pull(identifier _: String, fromPath _: String, toPath _: String) {}
    func remove(identifier _: String, path _: String) {}

    func wakeUpDevice(identifier _: String) {}

    func installAPK(identifier _: String, fromPath _: String) {}
}
