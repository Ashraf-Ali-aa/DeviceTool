import Foundation

final class Shell {
    var task: Process!

    func stop() {
        task.terminate()
    }

    func execute(command: String..., complete: @escaping (_ output: [String], _ error: [String], _ exitCode: Int32) -> Void) -> [String] {
        var output: [String] = []
        var error: [String] = []

        task = Process()
        let pipe = Pipe()

        task.launchPath = "/bin/bash"

        task.arguments = ["-c"] + command

        task.standardOutput = pipe
        task.standardError = pipe

        task.launch()

        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()

        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: pipe.fileHandleForReading, queue: nil
        ) { (_) -> Void in
            DispatchQueue.global(qos: .default).async(execute: { () -> Void in

                let outdata = pipe.fileHandleForReading.readDataToEndOfFile()
                if var string = String(data: outdata, encoding: .utf8) {
                    string = string.trimmingCharacters(in: .newlines)
                    output = string.components(separatedBy: "\n")
                }

                let errdata = pipe.fileHandleForReading.readDataToEndOfFile()
                if var string = String(data: errdata, encoding: .utf8) {
                    string = string.trimmingCharacters(in: .newlines)
                    error = string.components(separatedBy: "\n")
                }

                let status = self.task.terminationStatus
                DispatchQueue.main.async(execute: { () -> Void in
                    self.postNotification(message: output, channel: .scriptOutput)
                    complete(output, error, status)
                })
            })
        }
        return output
    }

    private func postNotification(message: [String], channel: ChannelType) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: channel.output),
            object: message.joined(separator: "\n")
        )
    }
}
enum ChannelType {
    case command
    case scriptOutput
    case verbose

    var output: String {
        switch self {
        case .command: return "dt.command"
        case .scriptOutput: return "dt.scriptOutput"
        case .verbose: return "dt.verbose"
        }
    }
}

let shell = Shell()

let item = shell.execute(command: "/usr/local/bin/ideviceinfo") { output, _, _ in

}

extension NotificationCenter {
    func get(channel: ChannelType) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: channel.output), object: nil, queue: nil) { (notification) -> Void in

            DispatchQueue.main.async(execute: { () -> Void in
                print(notification)
            })
        }
    }
}

NotificationCenter.default.get(channel: .scriptOutput)

