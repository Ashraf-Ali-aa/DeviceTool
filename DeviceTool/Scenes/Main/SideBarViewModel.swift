//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class SideBarViewModel {
    private(set) var selectedDeviceIndex: Dynamic<Int?> = Dynamic(nil)
    private(set) var devices: Dynamic<[Device]> = Dynamic([])

    public var devicesCount: Int {
        return devices.value.count
    }

    private var deviceInterface: DeviceInterface
    private let deviceControl = DeviceController()

    init(deviceInterface: DeviceInterface) {
        self.deviceInterface = deviceInterface
    }

    public func fetchDeviceList() {
        var previouslySelected: Device?

        // FIXME: incorrect index
        if let index = selectedDeviceIndex.value,
            index > 0,
            devices.value.count > index {
            previouslySelected = devices.value[index]
        }

        devices.value = deviceControl.getAllConnectedDevices()

        for (index, device) in devices.value.enumerated()
            where device.identifier == previouslySelected?.identifier {
            selectedDeviceIndex.value = index
            break
        }

        if selectedDeviceIndex.value == nil, devices.value.count > 0 {
            selectedDeviceIndex.value = 0
        } else {
            selectedDeviceIndex.value = nil
        }
    }

    public func selectDevice(atIndex index: Int) {
        selectedDeviceIndex.value = index
    }
}
