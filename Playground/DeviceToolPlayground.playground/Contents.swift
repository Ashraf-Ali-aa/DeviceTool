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

let commandOutput = shell.execute("/usr/local/bin/ideviceinfo")

let propertyDictionary = commandOutput.output.map { $0.components(separatedBy: ":") }.filter { !$0[0].isEmpty }.reduce(into: [String: String]()) { dictionary, pair in
    if pair.count == 2 {
        let value = pair.map { $0.trimmingCharacters(in: .whitespaces) }
        dictionary[value[0]] = value[1]
    }
}

print(propertyDictionary)
