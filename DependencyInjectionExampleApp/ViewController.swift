//
//  ViewController.swift
//  DependencyInjectionExampleApp
//
//  Created by Mark Bridges on 02/04/2020.
//  Copyright © 2020 BridgeTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let service: ExampleService

    init(service: ExampleService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
