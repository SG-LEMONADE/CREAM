//
//  UITextField+.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/04.
//

import UIKit

extension UITextField {
    func addButtonOnKeyboard(name: String) {
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let button = UIBarButtonItem(title: name, style: .done, target: self, action: #selector(didTapDoneButton))
        button.tintColor = .systemGray
        toolBar.items = [space, button]
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
    
    @objc
    func didTapDoneButton() {
        resignFirstResponder()
    }
}
