//
//  AppLogger.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import Foundation
import os

enum AppLogger {
    static let ui = Logger(subsystem: "com.debdutsaha.fandomsocial", category: "UI")
    static let network = Logger(subsystem: "com.debdutsaha.fandomsocial", category: "Network")
    static let db = Logger(subsystem: "com.debdutsaha.fandomsocial", category: "Database")
}
