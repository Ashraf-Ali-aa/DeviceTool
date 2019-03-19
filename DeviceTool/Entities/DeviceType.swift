//
//
//  Copyright © 2019 Michael Ovchinnikov. All rights reserved.
//

import Foundation

enum DeviceType: String {
    case phone, tablet, watch, tv, auto

    var imageName: String {
        switch self {
        case .phone: return "icon-phone"
        case .tablet: return "icon-tablet"
        case .watch: return "icon-watch"
        case .tv: return "icon-tv"
        case .auto: return "icon-auto"
        }
    }
}

extension DeviceType {
    init(characteristics: String) {
        if characteristics.contains("watch") || characteristics.contains("iwatch") {
            self = .watch
        } else if characteristics.contains("tablet") || characteristics.contains("ipad") {
            self = .tablet
        } else if characteristics.contains("tv") || characteristics.contains("apple tv") {
            self = .tv
        } else if characteristics.contains("auto") {
            self = .auto
        } else {
            self = .phone
        }
    }
}

enum PlatfromType: String {
    case ios = "iOS"
    case android = "Android"
    case mac = "MacOS"
    case linux = "Linux"
    case unknown = "Unknown"

    init(characteristics: String) {
        if characteristics.contains("iOS") {
            self = .ios
        } else if characteristics.contains("Android") {
            self = .android
        } else if characteristics.contains("MacOS") {
            self = .mac
        } else if characteristics.contains("Linux") {
            self = .linux
        } else {
            self = .unknown
        }
    }
}

enum HardwareType: String {
    case physical
    case simulator

    init(characteristics: String) {
        if characteristics.contains("physical") {
            self = .physical
        } else {
            self = .simulator
        }
    }
}

enum DeviceState: String {
    case online
    case offline
    case busy
    case error
}
