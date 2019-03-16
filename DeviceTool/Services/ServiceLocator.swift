//
//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Cocoa

final class ServiceLocator {
    static let shared = ServiceLocator()

    let shell = Shell()
    let defaults = Defaults()
    let adbWrapper: DeviceInterface

    let sidebarViewModel: SideBarViewModel
    let rebootViewModel: RebootCellViewModel
    let screenshotViewModel: ScreenshotCellViewModel
    let installAPKViewModel: InstallAPKCellViewModel
    let settingsViewModel: SettingsViewModel

    let viewControllerFactory: ViewControllerFactory
    let router: Router

    private init() {
        let platformToolsPath = defaults.string(forKey: .platformToolsPath) ?? ""
        adbWrapper = ADBInterface(shell: shell, platformToolsPath: platformToolsPath)

        sidebarViewModel = SideBarViewModel(adbWrapper: adbWrapper)
        rebootViewModel = RebootCellViewModel(adbWrapper: adbWrapper)
        screenshotViewModel = ScreenshotCellViewModel(adbWrapper: adbWrapper, settings: defaults)
        installAPKViewModel = InstallAPKCellViewModel(adbWrapper: adbWrapper)
        settingsViewModel = SettingsViewModel(settings: defaults)

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        viewControllerFactory = ViewControllerFactory(storyboard: storyboard)
        router = Router(viewControllerFactory: viewControllerFactory)
    }
}
