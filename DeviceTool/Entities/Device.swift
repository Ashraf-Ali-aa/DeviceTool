//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

struct Device {
    var identifier: String

    var deviceName: String
    var brand: DeviceBrand
    var model: String
    var manufacturer: String
    var type: DeviceType

    var properties: [String: String]
    var firstBoot: TimeInterval?
    var hardwareType: HardwareType?
    var platform: PlatfromType?
    var resolution: (width: Double, height: Double)?
    var state: DeviceState

    init(identifier: String, properties: [String: String]) {
        self.identifier = identifier

        deviceName = properties["model"] ?? ""
        brand = DeviceBrand(rawValue: properties["ro.product.brand"] ?? "") ?? .other
        model = properties["model"] ?? ""
        manufacturer = properties["ro.product.manufacturer"] ?? ""
        type = DeviceType(characteristics: properties["deviceType"] ?? "")

        self.properties = properties
        hardwareType = HardwareType(characteristics: properties["hardwareType"] ?? "")
        platform = PlatfromType(characteristics: properties["platform"] ?? "")
        state = .online
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
