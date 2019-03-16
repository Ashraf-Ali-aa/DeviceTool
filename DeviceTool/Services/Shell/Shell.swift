//
//  Copyright © 2019 Ashraf Ali. All rights reserved.
//

import Foundation

final class Shell: ShellType {
    @discardableResult
    public func execute(_ command: String) -> String {
        print(command)
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]

        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        let file = outputPipe.fileHandleForReading

        task.launch()

        if let result = NSString(data: file.readDataToEndOfFile(),
                                 encoding: String.Encoding.utf8.rawValue) {
            return (result as String).trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return ""
    }
}
