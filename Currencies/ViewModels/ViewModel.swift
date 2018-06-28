//
//  ViewModel.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import RxDataSources

class ViewModel{

    private var currencies :  [Currency]
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    var sections : [SectionModel] {
        return [SectionModel(header: "Currencies", items: currencies)]
    }
    
    var dataSource : RxTableViewSectionedAnimatedDataSource<SectionModel>{
        return RxTableViewSectionedAnimatedDataSource<SectionModel>(
            configureCell: { ds,tv,ip,item  in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
            cell.textLabel?.text = item.name
            return cell
        })
    }
}
