//
//  NavigationHandler.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import Foundation
import SwiftUI
import Combine
import os

final class Router: ObservableObject {
    static let shared = Router()
    @Published var screens: [Route] = []

    func push(_ screen: Route) {
        screens.append(screen)
    }
    func pushAsFirstMember(_ screen: Route) {
        screens.removeAll()
        screens.append(screen)
    }
    func pop() { _ = screens.popLast() }
    func reset() { screens.removeAll() }
}
