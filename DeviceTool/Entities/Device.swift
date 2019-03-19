//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

struct Device {
    var identifier: String
    var state: DeviceState
    var platform: PlatfromType
    var hardwareType: HardwareType
    var model: String
    var deviceName: String
    var type: DeviceType

    init(identifier: String, properties: [String: String]) {
        self.identifier = identifier
        state = .online
        platform = PlatfromType(characteristics: properties["platform"] ?? "")
        hardwareType = HardwareType(characteristics: properties["hardwareType"] ?? "")
        model = properties["model"] ?? ""
        deviceName = properties["model"] ?? ""
        type = DeviceType(characteristics: properties["deviceType"] ?? "")
    }
}
