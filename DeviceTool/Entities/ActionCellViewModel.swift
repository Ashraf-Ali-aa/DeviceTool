//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

class ActionCellViewModel {
    public var currentDevice: Device?

    var deviceInterface: DeviceInterface

    init(deviceInterface: DeviceInterface) {
        self.deviceInterface = deviceInterface
    }
}
