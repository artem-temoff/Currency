//
//  Currency.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import ObjectMapper
import RxSwift

struct Currency {
    
    var name : String
    var subtitle : String?
    var value = Variable<String>("")
    var bag = DisposeBag()
    
    init(name: String,subtitle:String?,value : String) {
        self.name = name
        self.value.value = value
        self.subtitle = subtitle
    }
}

struct CurrencyResponse : Mappable {
    
    var base : String
    var date : String
    var rates : [Currency]
    
    static let symbols : Dictionary<String, String> = {
        if let path = Bundle.main.path(forResource: "symbols", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let dictionary = dict as? Dictionary<String, String>{
            return dictionary
        }
        return [:]
    }()
    
    init?(map: Map) {
        
        guard let base:String = try? map.value("base"),
            let date:String = try? map.value("date"),
        let item = try? map.value("rates") as Dictionary<String, Double> else {
            return nil
        }
        
        self.base = base
        self.date = date
        rates =  item.flatMap { (arg) -> Currency? in
            let (key, value) = arg
            return Currency(name: key, subtitle: CurrencyResponse.symbols[key],value: String(value))
        }
        rates.sort { (lhr, rhr) -> Bool in
            return lhr.name < rhr.name
        }
    }
    
    mutating func mapping(map: Map) {
        
    }
}
