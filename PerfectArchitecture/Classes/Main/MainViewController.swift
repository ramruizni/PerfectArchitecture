//
//  ViewController.swift
//  PerfectArchitecture
//
//  Created by valid on 12/27/18.
//  Copyright © 2018 valid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var favoritesSwitch: UISwitch!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    let allTitles = Variable<[String]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateData()
        setupBindings()
    }

    func generateData() {
        for i in 0...100 {
            allTitles.value.append(String(i))
        }
    }
    
    func setupBindings() {
        Observable.combineLatest(allTitles.asObservable(), favoritesSwitch.rx.isOn, searchTextField.rx.text, resultSelector: { currentTitles, showFavorites, searchText in
            return currentTitles.filter { title -> Bool in
                self.validateIfShouldDisplayRow(showFavorites: showFavorites, searchText: searchText, title: title)
            }
        })
        .bind(to: tableView.rx.items(cellIdentifier: "mainTableViewCell", cellType: MainTableViewCell.self)) { _, title, cell in
            cell.setData(title, "Description description description description description description")
        }
        .disposed(by: disposeBag)
    }
    
    func validateIfShouldDisplayRow(showFavorites: Bool, searchText: String?, title: String) -> Bool {
        if let searchText = searchText, !searchText.isEmpty, !title.contains(searchText) {
            return false
        }
        return true
    }
    
}
