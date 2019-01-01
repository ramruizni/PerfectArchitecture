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
    
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    private enum SegueType: String {
        case detail = "toDetail"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.elements
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                return self.setupCell(tableView, row, element)
            }.disposed(by: disposeBag)
        
        favoritesSwitch.rx.isOn
            .subscribe(onNext: { value in
                self.viewModel.showFavorites.value = value
            }).disposed(by: disposeBag)
        
        searchTextField.rx.text
            .subscribe(onNext: { value in
                self.viewModel.searchText.value = value ?? ""
            }).disposed(by: disposeBag)
 
        tableView.rx.modelSelected(Element.self)
            .subscribe(onNext: { element in
                self.selectedTitle = element.name
                self.performSegue(withIdentifier: SegueType.detail.rawValue, sender: self)
            }).disposed(by: disposeBag)
    }
    
    func setupCell(_ tableView: UITableView, _ row: Int, _ element: Element) -> MainTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: IndexPath(row: row, section: 0)) as! MainTableViewCell
        cell.setData(withElement: element)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.name = selectedTitle ?? ""
        }
    }
    
}
