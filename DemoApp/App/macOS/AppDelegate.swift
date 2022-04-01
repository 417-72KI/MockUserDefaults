//
//  AppDelegate.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2022/04/01.
//  Copyright © 2022 417.72KI. All rights reserved.
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
