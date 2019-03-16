//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Cocoa

protocol InstallAPKCellViewModelType {
    func installAPK(atURL URL: NSURL)
}

final class InstallAPKCell: NSTableCellView {
    public var viewModel: InstallAPKCellViewModelType?

    @IBOutlet var dragView: DragView!

    override func awakeFromNib() {
        super.awakeFromNib()

        dragView.delegate = self
        dragView.acceptedFileExtensions = ["apk"]
    }
}

// MARK: - DragViewDelegate

extension InstallAPKCell: DragViewDelegate {
    func dragView(didDragFileWith URL: NSURL) {
        viewModel?.installAPK(atURL: URL)
    }
}
