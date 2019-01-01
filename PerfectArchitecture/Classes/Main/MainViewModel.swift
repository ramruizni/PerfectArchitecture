//
//  MainViewModel.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 1/1/19.
//  Copyright © 2019 valid. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    
    let elements: BehaviorSubject<[Element]>
    //let elements: Observable<[Element]>
    
    var selectedTitle: String?
    
    let showFavorites: Observable<Bool>
    let searchText: Observable<String>
    
    init() {
        let _showFavorites = Variable<Bool>(true)
        self.showFavorites = _showFavorites.asObservable().map { $0 }
        
        let _searchText = Variable<String>("azazazaz")
        self.searchText = _searchText.asObservable().map { $0 }
        
        var _elements = [Element]()
        for i in 0...100 {
            _elements.append(Element(String(i), "This is a random description for some element :D", i % 2 == 0))
        }
        self.elements = BehaviorSubject<[Element]>(value: _elements)
        
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
    
}
