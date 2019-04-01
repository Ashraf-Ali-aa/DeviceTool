//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

public class DeviceController: NSObject {
    let shell = Shell()
    let defaults = Defaults()

    func getAllConnectedDevices() -> [Device] {
        var deviceList = [Device]()

        deviceList += getAllIOSDevices()
        //        deviceList += getAllIOSSimulator()
        deviceList += getAllAndroidDevices()

        return deviceList
    }

    func getAllAndroidDevices() -> [Device] {
        let deviceInterface = ADBInterface(shell: shell)

        return deviceInterface.listDeviceIdentifiers().map { deviceInterface.getDevice(forId: $0) }
    }

    func getAllIOSDevices() -> [Device] {
        let deviceInterface = IDeviceInterface(shell: shell)

        return deviceInterface.listDeviceIdentifiers().map { deviceInterface.getDevice(forId: $0) }
    }

    func getAllIOSSimulator() -> [Device] {
        let deviceInterface = SimulatorInterface(shell: shell)

        return deviceInterface.listDeviceIdentifiers().map { deviceInterface.getDevice(forId: $0) }
    }

    func getDevice(interface: DeviceInterfaceController) -> DeviceInterface {
        switch interface {
        case .adb: return ADBInterface(shell: shell)
        case .iDevice: return IDeviceInterface(shell: shell)
        case .simlatorControl: return SimulatorInterface(shell: shell)
        case .cfgUtility: return IDeviceInterface(shell: shell)
        }
    }
}
