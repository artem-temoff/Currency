//
//  SectionModel.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//Copyright © 2018 company. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String
    var items: [Item]
}

extension SectionModel: AnimatableSectionModelType {
    
    typealias Item = Currency
    
    var identity: String {
        return header
    }
    
    init(original: SectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

extension Currency: IdentifiableType {
    
    typealias identity = String
    
    public var identity: String {
        return name
    }
    
}

extension Currency : Equatable{
    static func ==(lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name == rhs.name
    }
}
