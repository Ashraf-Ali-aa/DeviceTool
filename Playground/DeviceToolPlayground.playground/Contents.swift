import Foundation

protocol ShellType {
    @discardableResult
    func execute(_ command: String) -> (output: [String], error: [String], exitCode: Int32)
}

final class Shell: ShellType {
    @discardableResult
    public func execute(_ command: String) -> (output: [String], error: [String], exitCode: Int32) {
        print(command)
        return runCommand(cmd: "/bin/bash", args: "-c", command)
    }

    @discardableResult
    private func runCommand(cmd: String, args: String...) -> (output: [String], error: [String], exitCode: Int32) {
        var output: [String] = []
        var error: [String] = []

        let task = Process()
        task.launchPath = cmd
        task.arguments = args

        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe

        task.launch()

        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: outdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            output = string.components(separatedBy: "\n")
        }

        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: errdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            error = string.components(separatedBy: "\n")
        }

        task.waitUntilExit()
        let status = task.terminationStatus

        return (output, error, status)
    }
}

let shell = Shell()

let item = shell.execute("/usr/local/bin/ideviceinfo").output.map { $0.components(separatedBy: ":") }
    .reduce(into: [String: String]()) { dictionary, pair in
        if pair.count == 2 {
            dictionary[pair[0]] = pair[1]
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
                .joined(separator: " ")
        }
    }

print(item)
