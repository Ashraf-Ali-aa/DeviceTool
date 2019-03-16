//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

final class SettingsViewModel {
    public var platformToolsPath: Dynamic<String?> = Dynamic(nil)
    private var settings: Defaults

    init(settings: Defaults) {
        self.settings = settings
    }

    public func loadPlatformToolsPath() {
        platformToolsPath.value = settings.string(forKey: .platformToolsPath)
    }

    public func savePlatformToolsPath() {
        guard let path = platformToolsPath.value else { return }
        settings.setString(path, forKey: .platformToolsPath)
    }

    public func isADBAvailable() -> Bool {
        let path = platformToolsPath.value ?? ""
        return FileManager.default.fileExists(atPath: path)
    }
}
