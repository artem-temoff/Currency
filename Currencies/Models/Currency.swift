//
//  Currency.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import ObjectMapper

struct Currency {
    
    var name : String
    var value : Double
    
    init(name: String,value : Double) {
        self.name = name
        self.value = value
    }
}

struct CurrencyResponse : Mappable {
    
    var base : String
    var date : String
    var rates : [Currency]
    
    init?(map: Map) {
        
        guard let base:String = try? map.value("base"),
            let date:String = try? map.value("date"),
        let item = try? map.value("rates") as Dictionary<String, Double> else {
            return nil
        }
        self.base = base
        self.date = date
        rates =  item.flatMap { (key, value) -> Currency? in
            return Currency(name: key, value: value)
        }

    }
    
    mutating func mapping(map: Map) {
        
    }
}
