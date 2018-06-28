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
    
    var datasource = RxTableViewSectionedAnimatedDataSource<SectionModel>(configureCell: { ds,tv,ip,item  in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
        cell.title.text = item.name
        cell.value.text = String(item.value)
        cell.img.image =  UIImage(named: item.name)
        cell.subtitle.text = "foo"
        cell.selectionStyle = .none
        return cell
    })
        
   // lazy var itemsObservable : Observable<[Currency]> = self.currencies.asObservable()
    
    init() {
        fethCurrencies()
        //self.currencies = Variable<[Currency]>(currencies)
    }
    
    func fethCurrencies(){
        let provider = MoyaProvider<ApiService>()
        provider.rx.request(.fetch("EUR")).subscribe(onSuccess: { (response) in
            if (response.statusCode == 200){
                if let document = try? response.mapObject(CurrencyResponse.self){
                    self.currencies.value = document.rates
                    print("all OK")
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
    
    var sections : [SectionModel] {
        return [SectionModel(header: "Currencies", items: currencies.value)]
    }
    /*
    var dataSource : RxTableViewSectionedAnimatedDataSource<SectionModel>{
        return RxTableViewSectionedAnimatedDataSource<SectionModel>(
            configureCell: { ds,tv,ip,item  in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
            cell.title.text = item.name
            cell.value.text = String(item.value)
            cell.img.image =  UIImage(named: item.name)
            cell.subtitle.text = "foo"
            cell.selectionStyle = .none
            return cell
        })
    }
 */
}
