//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

class ActionCellViewModel {
    public var currentDevice: Device?

    var adbWrapper: DeviceInterface

    init(adbWrapper: DeviceInterface) {
        self.adbWrapper = adbWrapper
    }
}
