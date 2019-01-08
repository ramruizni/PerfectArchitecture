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
    private let element: Element
    
    init(rootViewController: UIViewController, element: Element) {
        self.rootViewController = rootViewController
        self.element = element
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        viewController.element = self.element
        rootViewController.show(viewController, sender: self)
        
        return Observable.never()
    }
    
}
