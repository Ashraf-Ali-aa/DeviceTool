//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

public struct Device {
    var identifier: String

    var deviceName: String
    var brand: DeviceBrand
    var model: String
    var manufacturer: String
    var osVersion: String
    var type: DeviceType

    var properties: [String: String]
    var firstBoot: TimeInterval?
    var hardwareType: HardwareType?
    var platform: PlatfromType?
    var resolution: (width: Double, height: Double)?
    var state: DeviceState
    var deviceInterface: DeviceInterfaceController

    init(
        identifier: String,
        type: DeviceType,
        deviceInterface: DeviceInterfaceController,
        deviceName: String?,
        brand: DeviceBrand?,
        model: String?,
        osVersion: String?,
        manufacturer: String?,

        properties: [String: String]?,
        firstBoot: TimeInterval?,
        hardwareType: HardwareType?,
        platform: PlatfromType?,
        resolution: (width: Double, height: Double)?,
        state: DeviceState?

    ) {
        self.identifier = identifier
        self.type = type
        self.deviceInterface = deviceInterface
        self.deviceName = deviceName ?? ""
        self.brand = brand ?? .other
        self.model = model ?? ""
        self.osVersion = osVersion ?? ""
        self.manufacturer = manufacturer ?? ""
        self.properties = properties ?? [:]
        self.firstBoot = firstBoot ?? 0.0
        self.hardwareType = hardwareType ?? .physical
        self.platform = platform ?? .unknown
        self.resolution = resolution ?? (0.0, 0.0)
        self.state = state ?? .unknown
    }
}

enum DeviceBrand: String {
    case apple
    case samsung
    case lg
    case huawei
    case xiaomi
    case oppo
    case vivo
    case lenovo
    case other
}
