//
//  ViewModel.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import RxDataSources
import RxSwift
import Moya
import Moya_ObjectMapper

class ViewModel{

    var symbols : [String:String]?
    let bag = DisposeBag()
    var currencies : Variable<[Currency]> = Variable<[Currency]>([])
    var base : Variable<String> = Variable<String>("EUR")
    var value = Variable<String>("1")
    
    var datasource = RxTableViewSectionedAnimatedDataSource<SectionModel>(configureCell: { (_,_,_,_) in
        return UITableViewCell()
    })
    
    init() {
        loadSymbols()
        print(symbols?.count)
        let timerSeq = Observable<Int>.timer(0, period: 5, scheduler: MainScheduler.instance).map { $0 as AnyObject }
        let variableSeq = value.asObservable().throttle(0.5, scheduler: MainScheduler.instance).map { $0 as AnyObject }
        Observable<AnyObject>.merge([timerSeq,variableSeq])
            .subscribe{ _ in
            self.fethCurrencies(base: self.base.value)
        }.disposed(by: bag)

    }
    
    func fethCurrencies(base : String){
        let provider = MoyaProvider<ApiService>()
        provider.rx.request(.fetch(base,value.value))
            .subscribe(onSuccess: { (response) in
            if (response.statusCode == 200){
                if let document = try? response.mapObject(CurrencyResponse.self){
                    self.processItems([Currency(name:base,value: self.value.value)] + document.rates)
                } else {
                    print("Can't make document")
                }
            } else {
                print("Response code = \(response.statusCode) ")
            }
        }) { (error) in
            print("error")
        }.disposed(by: bag)
    }

    func processItems(_ newItems: [Currency]){
        for value in newItems{
            if let index = self.currencies.value.index(of: value){
                if (self.currencies.value[index].name.elementsEqual(base.value)){
                    self.currencies.value[index].value.value = self.value.value
                    continue
                }
                self.currencies.value[index].value.value = value.value.value
            }else {
                self.currencies.value.append(value)
            }
        }
    }
    
    func loadSymbols(){
        if let path = Bundle.main.path(forResource: "symbols", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let dictionary = dict as? Dictionary<String, String>{
            symbols = dictionary
        }
    }
}

