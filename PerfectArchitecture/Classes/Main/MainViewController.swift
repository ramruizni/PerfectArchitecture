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
    let elements = Variable<[Element]>([])
    
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
            elements.value.append(Element(String(i), "This is a random description for some element :D", i % 2 == 0))
        }
    }
    
    func setupBindings() {
        Observable.combineLatest(elements.asObservable(), favoritesSwitch.rx.isOn, searchTextField.rx.text, resultSelector: { theElements, showFavorites, searchText in
            
            return (theElements as [Element]).filter { element -> Bool in
                    self.shouldDisplayRow(element, showFavorites, searchText, element.name!)
            }
            
        })
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: IndexPath(row: row, section: 0)) as! MainTableViewCell
                cell.setData(withElement: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Element.self)
            .subscribe(onNext: { element in
                self.cellPressed(withElement: element)
            })
        .disposed(by: disposeBag)
    }
    
    func shouldDisplayRow(_ element: Element, _ showFavorites: Bool, _ searchText: String?, _ name: String) -> Bool {
        if showFavorites && !element.isFavorite {
            return false
        }
        if let searchText = searchText, !searchText.isEmpty, !name.contains(searchText) {
            return false
        }
        return true
    }
    
    func cellPressed(withElement element: Element) {
        selectedTitle = element.name
        performSegue(withIdentifier: SegueType.detail.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.name = selectedTitle ?? ""
        }
    }
    
}
