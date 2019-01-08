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
        let viewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = MainViewModel()
        viewController.viewModel = viewModel
        
        viewModel.showElement
            .subscribe(onNext: { [weak self] element in
                self?.goToDetail(on: navigationController, withElement: element)
                }
            ).disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    @discardableResult
    func goToDetail(on rootViewController: UIViewController, withElement element: Element) -> Observable<Void> {
        let detailCoordinator = DetailCoordinator(rootViewController: rootViewController, element: element)
        return coordinate(to: detailCoordinator)
    }

}
