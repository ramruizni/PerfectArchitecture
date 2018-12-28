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
    
    var selectedTitle: String?
    
    private enum SegueType: String {
        case detail = "toDetail"
    }
    
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
                self.shouldDisplayRow(showFavorites: showFavorites, searchText: searchText, title: title)
            }
        })
            .bind(to: tableView.rx.items(cellIdentifier: "mainTableViewCell", cellType: MainTableViewCell.self)) { _, title, cell in
                cell.setData(title, "Description description description description description description")
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.cellPressed(indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    func shouldDisplayRow(showFavorites: Bool, searchText: String?, title: String) -> Bool {
        if let searchText = searchText, !searchText.isEmpty, !title.contains(searchText) {
            return false
        }
        return true
    }
    
    func cellPressed(_ row: Int) {
        selectedTitle = allTitles.value[row]
        performSegue(withIdentifier: SegueType.detail.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.name = selectedTitle ?? ""
        }
        
    }
    
}
