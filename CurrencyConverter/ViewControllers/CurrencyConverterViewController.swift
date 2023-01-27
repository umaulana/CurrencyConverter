//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by umam on 26/01/23.
//

import UIKit
import RxSwift

class CurrencyConverterViewController: UIViewController {
    @IBOutlet private weak var textFieldView: TextFieldView!
    @IBOutlet private weak var selectCurrencyButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupViews()
        bindEvents()
    }
    
    private func setupTitle() {
        title = "Currency Converter"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.magenta]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    private func setupViews() {
        textFieldView.configure(type: .number)
        dissmissKeyboardAfterTap()
    }
    
    private func bindEvents() {
        textFieldView.rxEventTextChanged
            .subscribe(onNext: { text in
                print(text)
            }).disposed(by: disposeBag)
        
        selectCurrencyButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dissmissKeyboard()
            }).disposed(by: disposeBag)
    }
    
    private func dissmissKeyboardAfterTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dissmissKeyboard() {
        view.endEditing(true)
    }
}
