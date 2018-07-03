//
//  ViewModelTests.swift
//  CurrenciesTests
//
//  Created by Eremenko on 02/07/2018.
//  Copyright © 2018 company. All rights reserved.
//

import XCTest
import UIKit
import RxDataSources
import RxSwift
import RxCocoa

@testable import Currencies

class ViewModelTests: XCTestCase {
    
    var vm : ViewModel?
    var dataSource : RxTableViewSectionedAnimatedDataSource<Currencies.SectionModel>!
    
    override func setUp() {
        super.setUp()
        dataSource = RxTableViewSectionedAnimatedDataSource<Currencies.SectionModel>(configureCell: { ds,tv,ip,item  in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
            cell.title.text = item.name
            item.value.asObservable().bind(to: cell.value.rx.text).disposed(by: item.bag)
            cell.img.image =  UIImage(named: item.name)
            cell.subtitle.text = item.subtitle
            cell.selectionStyle = .none
            return cell
        })
        vm = ViewModel(dataSource: dataSource)
    }
    
    override func tearDown() {
        vm = nil
        dataSource = nil
        super.tearDown()
    }
    
    func testInit() {
      
        XCTAssertNotNil(vm, "The view model should not be nil.")
        
    }
    
}
