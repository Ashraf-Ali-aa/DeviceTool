//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

final class RebootCellViewModel: ActionCellViewModel {}

extension RebootCellViewModel: RebootCellViewModelType {
    public func reboot(to: ADBRebootType) {
        guard let identifier = currentDevice?.identifier else { return }
        deviceInterface?.reboot(to: to, identifier: identifier)
    }
}
