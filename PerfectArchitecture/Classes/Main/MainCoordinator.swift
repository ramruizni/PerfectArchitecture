//
//  MainCoordinator.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 1/2/19.
//  Copyright © 2019 valid. All rights reserved.
//

import UIKit
import RxSwift

class MainCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MainViewModel()
        let viewController = MainViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.showElement
            .subscribe(onNext: { [weak self] element in
                self?.goToDetail(on: navigationController)
                }
            ).disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    func goToDetail(on rootViewController: UIViewController) -> Observable<Void> {
        let detailCoordinator = DetailCoordinator(rootViewController: rootViewController)
        return coordinate(to: detailCoordinator)
    }

}
