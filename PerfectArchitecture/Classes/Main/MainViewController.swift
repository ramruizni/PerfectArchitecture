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
    
    var selectedTitle: String?
    
    var viewModel: MainViewModel!
    let disposeBag = DisposeBag()
    
    private enum SegueType: String {
        case detail = "toDetail"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainTableViewCell")
        
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.elements
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                return self.setupCell(tableView, row, element)
            }.disposed(by: disposeBag)
        
        favoritesSwitch.rx.isOn
            .subscribe(onNext: { value in
                self.viewModel.showFavorites.accept(value)
            }).disposed(by: disposeBag)
        
        searchTextField.rx.text
            .subscribe(onNext: { value in
                self.viewModel.searchText.accept(value!)
            }).disposed(by: disposeBag)
 
        tableView.rx.modelSelected(Element.self)
            .bind(to: viewModel.selectElement) // it seems like it must be of type Element :D
            .disposed(by: disposeBag)
    }
    
    func setupCell(_ tableView: UITableView, _ row: Int, _ element: Element) -> MainTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: IndexPath(row: row, section: 0)) as! MainTableViewCell
        cell.setData(withElement: element)
        return cell
    }
    
}
