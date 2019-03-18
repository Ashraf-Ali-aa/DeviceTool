//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

class Defaults {
    enum Constant: String {
        case
            screenshotsSavePath,
            screenshotsShouldOpenPreview,
            platformToolsPath
    }

    func setString(_ value: String, forKey key: Constant) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func string(forKey key: Constant) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

    func setBool(_ value: Bool, forKey key: Constant) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func bool(forKey key: Constant) -> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
