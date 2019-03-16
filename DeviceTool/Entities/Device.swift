//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

struct Device {
    var identifier: String
    var model: String
    var type: DeviceType

    init(identifier: String, properties: [String: String]) {
        self.identifier = identifier
        model = properties["ro.product.model"] ?? ""
        type = DeviceType(characteristics: properties["ro.build.characteristics"] ?? "")
    }
}
