//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

enum ADBRebootType: String {
    case bootloader
    case recovery
    case system
}

final class ADBInterface: DeviceInterface {
    private let shell: ShellType
    private let platformToolsPath = Defaults().string(forKey: .platformToolsPath) ?? ""

    init(shell: ShellType) {
        self.shell = shell
    }

    public func listDeviceIdentifiers() -> [String] {
        let command = "\(platformToolsPath) devices"
        let deviceIdFilter: (String) -> Bool = { line in
            if line.isEmpty { return false }
            return line
                .components(separatedBy: .whitespaces)[1]
                .contains("device")
        }

        return shell.execute(command)
            .output
            .filter(deviceIdFilter)
            .map { $0.components(separatedBy: .whitespaces)[0] }
    }

    public func getDevice(forId identifier: String) -> Device {
        var properties = getDeviceProperties(serial: identifier)

        return Device(
            identifier: identifier,
            type: DeviceType(characteristics: properties["ro.build.characteristics"] ?? ""),
            deviceInterface: .adb,
            deviceName: properties["ro.product.model"],
            model: properties["ro.product.model"],
            osVersion: properties["ro.build.version.release"],
            properties: properties,
            hardwareType: .physical
        )
    }

    public func reboot(identifier: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, command: "reboot")
        )
    }

    public func reboot(to: ADBRebootType, identifier: String) {
        let rebootType = to == .system ? "" : to.rawValue
        shell.execute(
            adbTool(deviceSerial: identifier, command: "reboot \(rebootType)")
        )
    }

    public func takeScreenshot(identifier: String, path: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, shellCommand: "screencap -p \(path)")
        )
    }

    public func recordVideo(identifier: String, path: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, shellCommand: "screenrecord \(path)")
        )
    }

    public func pull(identifier: String, fromPath: String, toPath: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, command: "pull \(fromPath) \(toPath)")
        )
    }

    public func remove(identifier: String, path: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, shellCommand: "rm -f \(path)")
        )
    }

    public func wakeUpDevice(identifier: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, shellCommand: "input keyevent 82")
        )
    }

    public func installApplication(identifier: String, fromPath path: String) {
        shell.execute(
            adbTool(deviceSerial: identifier, command: "install \(path)")
        )
    }

    private func getDeviceProperties(serial identifier: String) -> [String: String] {
        let output = shell.execute(
            adbTool(deviceSerial: identifier, shellCommand: "getprop")
        ).output.joined(separator: "\n")

        return getPropsFromString(output)
    }

    private func getPropsFromString(_ string: String) -> [String: String] {
        guard
            let regularExpression = try? NSRegularExpression(
                pattern: "\\[(.+?)\\]: \\[(.+?)\\]",
                options: []
            ) else {
            return [:]
        }

        let matches = regularExpression.matches(
            in: string,
            options: [],
            range: NSRange(location: 0, length: string.utf16.count)
        )

        var propertyDictionary = [String: String]()

        for match in matches {
            let key = (string as NSString).substring(with: match.range(at: 1))
            let value = (string as NSString).substring(with: match.range(at: 2))
            propertyDictionary[key] = value
        }

        return propertyDictionary
    }

    private func adbTool(deviceSerial: String, command: String) -> String {
        return platformToolsPath + " " + "-s \(deviceSerial) " + command
    }

    private func adbTool(deviceSerial: String, shellCommand: String) -> String {
        return adbTool(deviceSerial: deviceSerial, command: "shell \(shellCommand)")
    }
}
