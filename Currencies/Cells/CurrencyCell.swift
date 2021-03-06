//
//  CurrencyCell.swift
//  Currencies
//
//  Created by Eremenko on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit
import SnapKit

class CurrencyCell: UITableViewCell {
    
    var img = UIImageView()
    var title = UILabel()
    var subtitle = UILabel()
    var value = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraints()
    }
    
    private func initializeUI(){
        contentView.addSubview(img)
        title.textColor = .black
        contentView.addSubview(title)
        subtitle.textColor = .gray
        contentView.addSubview(subtitle)
        value.keyboardType = .decimalPad
        value.placeholder = "0"
        value.textAlignment = .right
        contentView.addSubview(value)
        value.delegate = self
        
    }
    
    private func makeConstraints(){
        img.snp.makeConstraints{ (make) in
            make.height.width.equalTo(46)
            make.left.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView)
        }
        
         title.snp.makeConstraints{ make in
            make.top.equalTo(img)
            make.leading.equalTo(img.snp.trailing).offset(15)
         }
         
         subtitle.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalTo(title)
         }
         
         value.snp.makeConstraints{ make in
            make.height.equalTo(18)
           // make.width.equalTo(60)
            make.trailing.equalTo(contentView).offset(-15)
            make.centerY.equalTo(contentView)
         }
    }
    
}

extension CurrencyCell : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, text.count > 1{
            if (text.contains(".") && string.contains(".")){
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.sizeToFit()
    }
}
