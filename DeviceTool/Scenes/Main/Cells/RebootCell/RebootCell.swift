//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import AppKit

protocol RebootCellViewModelType {
    func reboot(to: ADBRebootType)
}

final class RebootCell: NSTableCellView {
    public var viewModel: RebootCellViewModelType?

    @IBAction func didPressRebootToROM(_: NSButton) {
        viewModel?.reboot(to: .system)
    }

    @IBAction func didPressRebootToBootloader(_: NSButton) {
        viewModel?.reboot(to: .bootloader)
    }

    @IBAction func didPressRebootToRecovery(_: NSButton) {
        viewModel?.reboot(to: .recovery)
    }
}
