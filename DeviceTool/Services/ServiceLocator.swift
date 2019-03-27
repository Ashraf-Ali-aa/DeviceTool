//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Cocoa

final class ServiceLocator {
    static let shared = ServiceLocator()

    let shell = Shell()
    let defaults = Defaults()
    let deviceController: DeviceController

    let sidebarViewModel: SideBarViewModel
    let rebootViewModel: RebootCellViewModel
    let screenshotViewModel: ScreenshotCellViewModel
    let installAPKViewModel: InstallAPKCellViewModel
    let settingsViewModel: SettingsViewModel

    let viewControllerFactory: ViewControllerFactory
    let router: Router

    private init() {
        deviceController = DeviceController()

        sidebarViewModel = SideBarViewModel(deviceController: deviceController)
        rebootViewModel = RebootCellViewModel()
        screenshotViewModel = ScreenshotCellViewModel(settings: defaults)
        installAPKViewModel = InstallAPKCellViewModel()
        settingsViewModel = SettingsViewModel(settings: defaults)

        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        viewControllerFactory = ViewControllerFactory(storyboard: storyboard)
        router = Router(viewControllerFactory: viewControllerFactory)
    }
}
