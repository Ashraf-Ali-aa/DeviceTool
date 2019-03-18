//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

protocol DeviceInterface {
    init(shell: ShellType, platformToolsPath: String)

    func listDeviceIdentifiers() -> [String]

    func getDevice(forId identifier: String) -> Device

    func reboot(identifier: String)

    func takeScreenshot(identifier: String, path: String)

    func recordVideo(identifier: String, path: String)

    func pull(identifier: String, fromPath: String, toPath: String)

    func remove(identifier: String, path: String)

    func wakeUpDevice(identifier: String)

    func installApplication(identifier: String, fromPath path: String)
}
