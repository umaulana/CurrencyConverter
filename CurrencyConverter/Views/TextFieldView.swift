//
//  TextFieldView.swift
//  CurrencyConverter
//
//  Created by umam on 26/01/23.
//

import UIKit
import RxCocoa
import RxSwift

class TextFieldView: UIView {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var leftImageView: UIImageView!
    
    private let eventTextChanged = PublishSubject<String>()
    var rxEventTextChanged: Observable<String> {
        return eventTextChanged
    }
    
    private let disposeBag = DisposeBag()
    private var isNumericOnly = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupViews()
        bindTextField()
    }
    
    private func setupViews() {
        textField.delegate = self
        textField.leftViewMode = .always
        layer.cornerRadius = 6
        showInactiveTextField()
    }
    
    private func bindTextField() {
        textField.rx.text
            .skip(1)
            .distinctUntilChanged()
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .subscribe { [weak self] text in
                guard let self = self, let text = text else { return }
                self.eventTextChanged.onNext(text)
            }.disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidBegin)
            .subscribe { [weak self] _ in
                self?.showActiveTextField()
            }.disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd)
            .subscribe { [weak self] _ in
                self?.showInactiveTextField()
                self?.addZeroIfNecessary()
            }.disposed(by: disposeBag)
        
    }
    
    func configure(type: TextFieldType) {
        if type == .search {
            configureSearchTextField()
        } else {
            configureNumberTextField()
        }
    }
    
    func reset() {
        textField.text = ""
    }
    
    private func configureSearchTextField() {
        textField.placeholder = "Search"
        leftImageView.image = UIImage(systemName: "magnifyingglass")
        textField.returnKeyType = .search
    }
    
    private func configureNumberTextField() {
        textField.placeholder = "0.0"
        leftImageView.image = UIImage(systemName: "dollarsign.square")
        textField.keyboardType = .decimalPad
        isNumericOnly = true
    }
    
    private func showActiveTextField() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.magenta.cgColor
            self.layer.borderWidth = 1
            self.leftImageView.tintColor = .magenta
        }
    }
    
    private func showInactiveTextField() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 0.5
            self.leftImageView.tintColor = .lightGray
        }
    }
    
    private func addZeroIfNecessary() {
        guard let text = textField.text else { return }
        
        textField.text = text.addZeroIfNecessary
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isNumericOnly {
            if let text = textField.text, string == ".", Set(text).contains(string) {
                return false
            }
            
            let allowedCharacters = Set("1234567890.")
            let characterSet = Set(string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}
