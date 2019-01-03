//
//  AppCoordinator.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 1/2/19.
//  Copyright © 2019 valid. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let repositoryListCoordinator = MainCoordinator(window: window)
        return coordinate(to: repositoryListCoordinator)
    }
}
