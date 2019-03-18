//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

struct Device {
    var identifier: String
    var platform: PlatfromType
    var hardwareType: HardwareType
    var model: String
    var deviceName: String
    var type: DeviceType

    init(identifier: String, properties: [String: String]) {
        self.identifier = identifier
        platform = .android
        hardwareType = .physical
        model = properties["ro.product.model"] ?? ""
        deviceName = properties["ro.product.model"] ?? ""
        type = DeviceType(characteristics: properties["ro.build.characteristics"] ?? "")
    }
}
