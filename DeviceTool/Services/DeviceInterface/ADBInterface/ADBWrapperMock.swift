//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class ADBWrapperMock: DeviceInterface {
    func reboot(identifier _: String) {}

    func recordVideo(identifier _: String, path _: String) {}

    init(shell _: ShellType) {}

    func listDeviceIdentifiers() -> [String] {
        return ["phone", "tablet", "watch", "tv", "auto"]
    }

    func getDevice(forId identifier: String) -> Device {
        return Device(
            identifier: identifier,
            type: .phone,
            deviceInterface: .adb,
            deviceName: "",
            brand: .samsung,
            model: "",
            osVersion: "",
            manufacturer: "",
            properties: [
                "ro.product.model": identifier,
                "ro.build.characteristics": identifier,
            ],
            firstBoot: 0,
            hardwareType: .simulator,
            platform: .android,
            resolution: (0, 0),
            state: .unknown
        )
    }

    public func reboot(to _: ADBRebootType, identifier _: String) {}

    func takeScreenshot(identifier _: String, outputFolder _: String, fileName _: String) {}

    func takeScreenshot(identifier _: String, path _: String) {}

    func pull(identifier _: String, fromPath _: String, toPath _: String) {}
    func remove(identifier _: String, path _: String) {}

    func wakeUpDevice(identifier _: String) {}

    func installApplication(identifier _: String, fromPath _: String) {}
}
