//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class IDeviceInterface: DeviceInterface {
    private let shell: ShellType
    private let platformToolsPath = Defaults().string(forKey: .platformToolsPath) ?? ""

    init(shell: ShellType) {
        self.shell = shell
    }

    func listDeviceIdentifiers() -> [String] {
        return shell.execute("idevice_id -l").output
    }

    func getDevice(forId identifier: String) -> Device {
        var properties = getDeviceProperties(serial: identifier)

        return Device(
            identifier: identifier,
            type: DeviceType(characteristics: properties["DeviceClass"] ?? ""),
            deviceInterface: .iDevice,
            deviceName: properties["DeviceName"],
            model: properties["ProductType"],
            osVersion: properties["ProductVersion"],
            properties: properties,
            hardwareType: .physical,
            platform: .ios
        )
    }

    func reboot(identifier _: String) {}

    func reboot(to _: ADBRebootType, identifier _: String) {}

    func takeScreenshot(identifier: String, outputFolder: String, fileName: String) {
        print("hello - screenshot")

        takeScreenshot(identifier: identifier, path: outputFolder + fileName)
    }

    func takeScreenshot(identifier: String, path: String) {
        shell.execute(
            idevicescreenshot(deviceSerial: identifier, command: path)
        )
    }

    func recordVideo(identifier _: String, path _: String) {}

    func pull(identifier _: String, fromPath _: String, toPath _: String) {}

    func remove(identifier _: String, path _: String) {}

    func wakeUpDevice(identifier _: String) {}

    func installApplication(identifier _: String, fromPath _: String) {}

    private func getDeviceProperties(serial identifier: String) -> [String: String] {
        let commandOutput = shell.execute(
            ideviceInfo(deviceSerial: identifier, command: "")
        )

        guard commandOutput.exitCode == 0 else {
            print("Error:")
            print(commandOutput.error)
            return [:]
        }

        let propertyDictionary = commandOutput.output.map { $0.components(separatedBy: ":") }.filter { !$0[0].isEmpty }.reduce(into: [String: String]()) { dictionary, pair in
            if pair.count == 2 {
                let value = pair.map { $0.trimmingCharacters(in: .whitespaces) }
                dictionary[value[0]] = value[1]
            }
        }

        return propertyDictionary
    }

    private func ideviceInfo(deviceSerial: String, command: String) -> String {
        return "ideviceinfo -u \(deviceSerial) \(command)"
    }

    private func idevicescreenshot(deviceSerial: String, command: String) -> String {
        return "idevicescreenshot -u \(deviceSerial) " + command
    }
}
