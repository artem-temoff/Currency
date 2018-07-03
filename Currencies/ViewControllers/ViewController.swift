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
    var tmpBug : DisposeBag? = DisposeBag()
    var tableView : UITableView!
    var viewModel : ViewModel!
    var subscription : Disposable?
    
    var dataSource = RxTableViewSectionedAnimatedDataSource<SectionModel>(configureCell: { ds,tv,ip,item  in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! CurrencyCell
        cell.title.text = item.name
        item.value.asObservable().bind(to: cell.value.rx.text).disposed(by: item.bag)
        cell.img.image =  UIImage(named: item.name)
        cell.subtitle.text = item.subtitle
        cell.selectionStyle = .none
        return cell
    })
    
    lazy var dataModel: ViewModel = {
        let vm = ViewModel(dataSource: dataSource)
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        dataModel.currencies.asObservable()
            .map({ [SectionModel(header:"",items:$0)] })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.delegate = self
        
        tableView.rx.modelSelected(Currency.self)
            .subscribe{ element in
            if let element = element.element, let row = self.dataModel.currencies.value.index(of: element){
               let cell = (self.tableView?.cellForRow(at: IndexPath(row: row, section: 0)) as! CurrencyCell)
                self.subscription = cell.value.rx.text
                    .subscribe( onNext : { element in
                    if let element = element{
                        self.dataModel.value.value = element
                    }
                })
               cell.value.becomeFirstResponder()
               self.dataModel.currencies.value.swapAt(0, row)
               self.dataModel.base.value = self.dataModel.currencies.value[0].name
                DispatchQueue.main.async {
                    self.tableView.scrollToRow(at: IndexPath(row:0,section:0), at: UITableViewScrollPosition.top, animated: true)
                }
            }
            }.disposed(by: bag)
        
        
        tableView.rx.modelDeselected(Currency.self)
        .subscribe{ element in
            self.subscription?.dispose()
        }.disposed(by: bag)
        
    }
    
    func setupUI() {
        tableView = UITableView()
        tableView.accessibilityIdentifier = "tableView"
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        makeConstraints()
    }
    
    func makeConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset.bottom = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset.bottom = 0
    }

}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}




