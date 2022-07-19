//
//  Config.swift
//  TestApp
//
//  Created by iMac on 2022/07/20.
//

import Foundation

enum ServerInfo {
    case local
    case remote
}

struct Config {
    static var serverInfo: ServerInfo = .local
}
