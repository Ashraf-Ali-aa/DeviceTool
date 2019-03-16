//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

final class RebootCellViewModel: ActionCellViewModel {}

extension RebootCellViewModel: RebootCellViewModelType {
    public func reboot(to: ADBRebootType) {
        guard let identifier = currentDevice?.identifier else { return }
        adbWrapper.reboot(to: to, identifier: identifier)
    }
}
