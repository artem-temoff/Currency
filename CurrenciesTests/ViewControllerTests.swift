//
//  ViewControllerTests.swift
//  CurrenciesTests
//
//  Created by Eremenko on 02/07/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import XCTest
import RxDataSources
import RxSwift

@testable import Currencies

class ViewControllerTests: XCTestCase {
    
    var dataSource : RxTableViewSectionedAnimatedDataSource<Currencies.SectionModel>!
    var tableView : UITableView!
    var dataModel : ViewModel!
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        tableView = UITableView()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        
        dataSource = RxTableViewSectionedAnimatedDataSource<Currencies.SectionModel>(configureCell: { ds,tv,ip,item  in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
            cell.title.text = item.name
            item.value.asObservable().bind(to: cell.value.rx.text).disposed(by: item.bag)
            cell.img.image =  UIImage(named: item.name)
            cell.subtitle.text = item.subtitle
            cell.selectionStyle = .none
            return cell
        })
    }
    
    override func tearDown() {
        dataSource = nil
        tableView = nil
        super.tearDown()
    }
    
    func test() {

        Observable<[Currencies.SectionModel]>
            .of([SectionModel(header:"",items:[Currency(name: "EUR", subtitle: "foo", value: "1.2"),
                                               Currency(name: "USD", subtitle: "foo", value: "1.4"),
                                               Currency(name: "RUB", subtitle: "foo", value: "70.3")])])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(dataSource.sectionModels.count, 1)
        XCTAssertEqual(tableView.numberOfSections, 1)
        XCTAssertEqual(dataSource.sectionModels.first?.items.count , 3)
        XCTAssertEqual(dataSource.sectionModels.first?.items.count,tableView.numberOfRows(inSection: 0))
        
    }
    
}
