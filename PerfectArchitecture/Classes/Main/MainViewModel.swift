//
//  MainViewModel.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 1/1/19.
//  Copyright © 2019 valid. All rights reserved.
//

import RxSwift

class MainViewModel {

    var _elements = Variable<[Element]>([])
    var showFavorites = Variable<Bool>(false)
    let searchText = Variable<String>("")
    
    var elements: Observable<[Element]>
    
    let selectElement: AnyObserver<Element>
    let showElement: Observable<Element>
    
    init() {
        
        let _selectElement = PublishSubject<Element>()
        self.selectElement = _selectElement.asObserver()
        self.showElement = _selectElement.asObservable()
        
        
        
        
        
        elements = _elements.asObservable()
        elements = Observable.combineLatest(_elements.asObservable(), showFavorites.asObservable(), searchText.asObservable(), resultSelector: { elements, showFavorites, searchText in
            return self.elementsToDisplay(elements, showFavorites, searchText)
        })
        
        populateElements()
    }
    
    func elementsToDisplay(_ elements: [Element], _ showFavorites: Bool, _ searchText: String) -> [Element] {
        return (elements as [Element]).filter { element -> Bool in
            if showFavorites && !element.isFavorite {
                return false
            } else if !searchText.isEmpty, !element.name!.contains(searchText) {
                return false
            } else {
                return true
            }
        }
    }
    
    func populateElements() {
        for i in 0...10000 {
            _elements.value.append(Element(String(i), "This is a random description for some element :D", i % 2 == 0))
        }
    }
    
}
