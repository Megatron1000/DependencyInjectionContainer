//
//  AppDelegate.swift
//  DependencyInjectionExampleApp
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import UIKit
import DependencyInjectionContainer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    let dependencyContainer = DependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Register all the dependencies here
        dependencyContainer.register {
            DefaultExampleService() as ExampleService
        }
        
        // Resolve a dependency like so
        let viewController = ViewController(service: dependencyContainer.resolve())
        
        // Window initialisation boiler plate
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

