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
    private var tableView : UITableView!
    var viewModel : ViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel = ViewModel(currencies: [Currency(name: "EUR", value: 23.46),Currency(name: "CZK", value: 23.46),
                                           Currency(name: "USD", value: 25.46),Currency(name: "AUD", value: 22.46)])
        
        Observable.just(viewModel.sections)
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
  
        tableView.delegate = self

        
        tableView.rx.modelSelected(Currency.self).subscribe{ element in
            if let element = element.element, let row = self.viewModel.currencies.index(of: element){
                let indexPath = IndexPath(row: row, section: 0)
                self.tableView.beginUpdates()
                self.tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
                self.tableView.endUpdates()
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CurrencyCell
                cell?.value.becomeFirstResponder()
            }
            }.disposed(by: bag)
 
    }
    
    func setupUI() {
        tableView = UITableView()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        makeConstraints()
    }
    
    func makeConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


