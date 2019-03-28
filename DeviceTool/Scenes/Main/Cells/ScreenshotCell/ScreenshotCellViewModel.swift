//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Cocoa

final class ScreenshotCellViewModel: ActionCellViewModel {
    private(set) var savePath: Dynamic<String> = Dynamic("~/Desktop")
    private(set) var shouldOpenPreview: Dynamic<Bool> = Dynamic(true)

    private let defaults: Defaults

    init(settings: Defaults) {
        defaults = settings

        super.init()

        restoreDefaults()
    }

    private func restoreDefaults() {
        if let savePath = defaults.string(forKey: .screenshotsSavePath) {
            self.savePath.value = savePath
        }

        if let shouldOpenPreview = defaults.bool(forKey: .screenshotsShouldOpenPreview) {
            self.shouldOpenPreview.value = shouldOpenPreview
        }
    }
}

extension ScreenshotCellViewModel: ScreenShotCellViewModelType {
    public func takeScreenshot() {
        guard
            let platform = self.currentDevice?.platform,
            let identifier = self.currentDevice?.identifier,
            let deviceModel = self.currentDevice?.model else {
            return
        }

        let modelName = deviceModel.toFilenameString()
        let filename = "\(modelName)-\(Date().toFilenameString()).png"
        let filePath = platform == .android ? "/sdcard/\(filename)" : "/\(filename)"
        let selectedFolder = NSString(string: savePath.value).expandingTildeInPath

        deviceInterface?.takeScreenshot(
            identifier: identifier,
            outputFolder: selectedFolder,
            fileName: filePath
        )

        if shouldOpenPreview.value {
            let localSreenshotPath = "\(selectedFolder)/\(filename)"
            NSWorkspace.shared.openFile(localSreenshotPath)
        }
    }

    public func updateDefaults() {
        defaults.setBool(shouldOpenPreview.value, forKey: .screenshotsShouldOpenPreview)
        defaults.setString(savePath.value, forKey: .screenshotsSavePath)
    }
}
