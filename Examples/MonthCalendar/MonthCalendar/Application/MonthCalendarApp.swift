//
//  MonthCalendarApp.swift
//  MonthCalendar
//
//  Created by Tiago Lopes on 05/01/22.
//

import SwiftUI
import UIKit

// MARK: - Application

@main
struct MonthCalendarApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var delegate
    
    var body: some Scene {
        WindowGroup {
            MonthCalendar()
        }
    }
}

// MARK: - Delegate

fileprivate final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        true
    }
    
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        .portrait
    }
}
