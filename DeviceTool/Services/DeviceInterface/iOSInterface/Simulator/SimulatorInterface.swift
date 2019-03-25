//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class SimulatorInterface: DeviceInterface {
    private let shell: ShellType
    private let platformToolsPath = Defaults().string(forKey: .platformToolsPath) ?? ""

    init(shell: ShellType) {
        self.shell = shell
    }

    func listDeviceIdentifiers() -> [String] {
        return shell.execute("simctl list --json").output
    }

    func getDevice(forId identifier: String) -> Device {
        return Device(identifier: identifier, type: .phone, deviceInterface: .simlatorControl, properties: [:])
    }

    func reboot(identifier _: String) {}

    func reboot(to _: ADBRebootType, identifier _: String) {}

    func takeScreenshot(identifier _: String, path _: String) {}

    func recordVideo(identifier _: String, path _: String) {}

    func pull(identifier _: String, fromPath _: String, toPath _: String) {}

    func remove(identifier _: String, path _: String) {}

    func wakeUpDevice(identifier _: String) {}

    func installApplication(identifier _: String, fromPath _: String) {}
}
