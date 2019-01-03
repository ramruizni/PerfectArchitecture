//
//  DetailCoordinator.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 1/3/19.
//  Copyright © 2019 valid. All rights reserved.
//

import UIKit
import RxSwift

class DetailCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<CoordinationResult> {
        
        let viewController = DetailViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        rootViewController.present(navigationController, animated: true)
        
        return Observable.never()
    }
    
}
