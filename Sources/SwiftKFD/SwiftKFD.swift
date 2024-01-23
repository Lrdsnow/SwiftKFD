import SwiftKFD_objc

class deviceInfo {
    enum DeviceFamily: Int {
        case unknown
        case iOS
        case iPadOS
        case macOS
        case watchOS
        case tvOS
    }
    
    enum KFDType: Int {
        case landa
        case smith
        case incompatible
    }
    
    static func getVersionArray() -> [Int] {
        let processInfo = ProcessInfo.processInfo
        let systemVersion = processInfo.operatingSystemVersionString
        let versionComponents = systemVersion.split(separator: ".").compactMap { Int($0) }
        var version = [99, 0, 0] // 99 to prevent accidental exploit lol
        if versionComponents.count >= 1 {
            version[0] = versionComponents[0]
        }
        if versionComponents.count >= 2 {
            version[1] = versionComponents[1]
        }
        if versionComponents.count >= 3 {
            version[2] = versionComponents[2]
        }
        return version
    }
    
    static func getDeviceType() -> DeviceFamily {
        #if os(iOS)
        return .iOS
        #elseif os(iPadOS)
        return .iPadOS
        #elseif os(macOS)
        return .macOS
        #elseif os(watchOS)
        return .watchOS
        #elseif os(tvOS)
        return .tvOS
        #else
        return .unknown
        #endif
    }
    
    static func getKFDType() -> KFDType {
        let deviceType = self.getDeviceType()
        let versionArray = self.getVersionArray()
        if deviceType == .iOS || deviceType == .iPadOS {
            if versionArray.lexicographicallyPrecedes([16, 5, 1]) {
                return .smith
            } else if versionArray.lexicographicallyPrecedes([16, 7, 0]) {
                return .landa
            } else {
                return .incompatible
            }
        } else if deviceType == .macOS {
            if versionArray.lexicographicallyPrecedes([13, 5, 2]) {
                return .smith
            } else if versionArray.lexicographicallyPrecedes([14, 0, 0]) {
                return .landa
            } else {
                return .incompatible
            }
        } else if deviceType == .watchOS {
            if versionArray.lexicographicallyPrecedes([8, 8, 1]) || (versionArray.lexicographicallyPrecedes([9, 5, 2]) &&
                                                                     versionArray.lexicographicallyPrecedes([9, 5, 2]) &&
                                                                     versionArray.lexicographicallyPrecedes([9, 0, 0])) {
                return .smith
            } else if versionArray.lexicographicallyPrecedes([10, 0, 0]) {
                return .landa
            } else {
                return .incompatible
            }
        } else if deviceType == .tvOS {
            if versionArray.lexicographicallyPrecedes([17, 3, 0]) {
                return .landa
            } else {
                return .incompatible
            }
        } else {
            return .incompatible
        }
    }
    
    static func getPuafPages() -> UInt64 {
        let deviceType = self.getDeviceType()
        if deviceType == .iOS {
            return 3072
        } else if deviceType == .iPadOS || deviceType == .macOS {
            return 4096
        } else {
            return 2048
        }
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

public func SmartKopen(_ puaf_pages: UInt64? = nil, _ puaf_method: UInt64? = nil, _ headroom: Int = -1, _ forcekfd: Bool = false) throws {
    let kfdtype = deviceInfo.getKFDType()
    if kfdtype != .incompatible || forcekfd {
        do_kopen(puaf_pages ?? deviceInfo.getPuafPages(), puaf_method ?? (kfdtype == .smith ? 1 : 2), 1, 1, headroom)
    } else {
        throw "Unsupported Version"
    }
}

public func SmartKclose() {
    // just a proxy to kclose lol
    do_kclose()
}
