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

        let installer = ServiceLocator.shared.installer

        if platformToolsPath != nil {
            router.presentMainController()
        } else {
            
            if !installer.isBrewInstalled {
                installer.brewInstall()
            }
            
            if !installer.isIDevcieInstalled {
                installer.installIDevice()
            }
            
            if !installer.isADBInstalled {
                installer.installADB()
            }

            router.presentSettingsController()
        }

    }
}
