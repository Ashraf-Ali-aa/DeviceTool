//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        let defaults = ServiceLocator.shared.defaults
        let platformToolsPath = defaults.string(forKey: .platformToolsPath)
        let router = ServiceLocator.shared.router
        if platformToolsPath != nil {
            router.presentMainController()
        } else {
            router.presentSettingsController()
        }
    }
}
