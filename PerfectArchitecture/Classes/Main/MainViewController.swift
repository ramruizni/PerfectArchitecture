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
        
        viewModel.elements.asObservable()
        /*
        Observable.combineLatest(viewModel.elements.asObservable(), favoritesSwitch.rx.isOn, searchTextField.rx.text, resultSelector: { theElements, showFavorites, searchText in
            return (theElements as [Element]).filter { element -> Bool in
                    self.viewModel.shouldDisplayRow(element, showFavorites, searchText, element.name!)
            }
        })*/
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                return self.setupCell(tableView, row, element)
            }
            .disposed(by: disposeBag)
        
        viewModel.showFavorites
            .bind(to: favoritesSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        viewModel.searchText
            .bind(to: searchTextField.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Element.self)
            .subscribe(onNext: { element in
                self.viewModel.selectedTitle = element.name
                self.performSegue(withIdentifier: SegueType.detail.rawValue, sender: self)
            })
        .disposed(by: disposeBag)
    }
    
    func setupCell(_ tableView: UITableView, _ row: Int, _ element: Element) -> MainTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: IndexPath(row: row, section: 0)) as! MainTableViewCell
        cell.setData(withElement: element)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.name = viewModel.selectedTitle ?? ""
        }
    }
    
}
