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

    var deviceNames: [JSONReportElement]?

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

        deviceNames = loadJson(filename: "devices")
    }

    func loadJson(filename fileName: String) -> [JSONReportElement]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let jSONReport = try? JSONDecoder().decode(JSONReport.self, from: jsonData)

                return jSONReport
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

typealias JSONReport = [JSONReportElement]

public struct JSONReportElement: Codable {
    public let identifier, name, brand, type: String

    public init(identifier: String, name: String, brand: String, type: String) {
        self.identifier = identifier
        self.name = name
        self.brand = brand
        self.type = type
    }
}
