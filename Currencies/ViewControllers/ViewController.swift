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

        viewModel = ViewModel()
        viewModel?.datasource.configureCell = { ds,tv,ip,item  in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
            cell.title.text = item.name
            cell.value.text = String(item.value)
            cell.img.image =  UIImage(named: item.name)
            cell.subtitle.text = "foo"
            cell.selectionStyle = .none
            return cell
        }
        
        if let ds = viewModel?.datasource {
            viewModel.currencies.asObservable()
                .map({ [SectionModel(header:"1",items:$0)] })
                .bind(to: tableView.rx.items(dataSource: ds))
                .disposed(by: bag)
        }

        tableView.delegate = self

        
        tableView.rx.modelSelected(Currency.self).subscribe{ element in
            if let element = element.element, let row = self.viewModel.currencies.value.index(of: element){
                let indexPath = IndexPath(row: row, section: 0)
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
                    self.tableView.endUpdates()
                }
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


