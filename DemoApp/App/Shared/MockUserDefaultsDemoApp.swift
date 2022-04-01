//
//  MockUserDefaultsDemoApp.swift
//  Shared
//
//  Created by 417.72KI on 2022/04/01.
//  Copyright © 2022 417.72KI. All rights reserved.
//

import SwiftUI

@main
struct MockUserDefaultsDemoApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
