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

    let bag = DisposeBag()
    var currencies : Variable<[Currency]> = Variable<[Currency]>([])
    var base : Variable<String> = Variable<String>("EUR")
    var value = Variable<Double>(1)
    
    var datasource = RxTableViewSectionedAnimatedDataSource<SectionModel>(configureCell: { (_,_,_,_) in
        return UITableViewCell()
    })
    
    init() {

        Observable<Int>.interval(5, scheduler: MainScheduler.instance).subscribe{ _ in
            self.fethCurrencies(base: self.base.value)
        }.disposed(by: bag)
        
    }
    
    func fethCurrencies(base : String){
        let provider = MoyaProvider<ApiService>()
        provider.rx.request(.fetch(base,String(value.value)))
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
                    // TODO fix numbers after point in double string
                    self.currencies.value[index].value.value = "\(self.value.value)"
                    continue
                }
                self.currencies.value[index].value.value = value.value.value
            }else {
                self.currencies.value.append(value)
            }
        }
    }
}
