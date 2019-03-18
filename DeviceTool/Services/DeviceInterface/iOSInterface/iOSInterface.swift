//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class IOSInterface: DeviceInterface {
    private let platformToolsPath: String
    private let shell: ShellType

    init(shell: ShellType, platformToolsPath: String) {
        self.platformToolsPath = platformToolsPath
        self.shell = shell
    }

    func listDeviceIdentifiers() -> [String] {
        return shell.execute("idevice_id -l").output
    }

    func getDevice(forId identifier: String) -> Device {
        return Device(identifier: identifier, properties: [:])
    }

    func reboot(identifier _: String) {}

    func takeScreenshot(identifier _: String, path _: String) {}

    func recordVideo(identifier _: String, path _: String) {}

    func pull(identifier _: String, fromPath _: String, toPath _: String) {}

    func remove(identifier _: String, path _: String) {}

    func wakeUpDevice(identifier _: String) {}

    func installApplication(identifier _: String, fromPath _: String) {}
}
