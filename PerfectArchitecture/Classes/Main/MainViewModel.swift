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

    var _elements = Variable<[Element]>([])
    var showFavorites = Variable<Bool>(false)
    let searchText = Variable<String>("")
    
    var elements: Observable<[Element]>
    
    init() {
        elements = Observable.combineLatest(_elements.asObservable(), showFavorites.asObservable(), searchText.asObservable(), resultSelector: { elements, showFavorites, searchText in
            return (elements as [Element]).filter { element -> Bool in
                if showFavorites && !element.isFavorite {
                    return false
                } else if !searchText.isEmpty, !element.name!.contains(searchText) {
                    return false
                } else {
                    return true
                }
            }
        })
        
        populateElements()
    }
    
    func populateElements() {
        for i in 0...100 {
            _elements.value.append(Element(String(i), "This is a random description for some element :D", i % 2 == 0))
        }
    }
    
}
