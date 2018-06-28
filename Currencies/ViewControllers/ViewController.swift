//
//  ViewController.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let bag = DisposeBag()
    private var tableVeiw : UITableView!
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel = ViewModel(currencies: [Currency(name: "test1", value: 23.46),Currency(name: "test2", value: 23.46),
                                           Currency(name: "test3", value: 25.46),Currency(name: "test4", value: 22.46)])
        
        Observable.just(viewModel.sections).bind(to: tableVeiw.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
    }
    
    func setupUI() {
        tableVeiw = UITableView()
        tableVeiw.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableVeiw)
        
        makeConstraints()
    }
    
    func makeConstraints(){
        tableVeiw.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


