//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

class Installer {
    let shell = Shell()
    let defaults = Defaults()

    var isBrewInstalled: Bool {
        return shell.execute("which brew").output.contains("/usr/local/bin/brew")
    }

    var isIDevcieInstalled: Bool {
        let idevice = [
            shell.execute("which ideviceinfo").output,
            shell.execute("which ideviceinstaller").output
        ]

        return idevice.contains(where: { $0.contains("/usr/local/bin/") })
    }

    var isADBInstalled: Bool {
        let adb = shell.execute("which adb").output

        return adb.contains("/usr/local/bin/")
    }

    func brewInstall() {
        shell.execute("/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
    }

    func installIDevice() {
        shell.execute("/usr/local/bin/brew update")
        shell.execute("/usr/local/bin/brew install --HEAD usbmuxd")
        shell.execute("/usr/local/bin/brew link usbmuxd")
        shell.execute("/usr/local/bin/brew install --HEAD libimobiledevice")
        shell.execute("/usr/local/bin/brew install ideviceinstaller")
    }

    func installADB() {
        shell.execute("/usr/local/bin/brew install android-platform-tools")
    }


}
