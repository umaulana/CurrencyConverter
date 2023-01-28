//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by umam on 26/01/23.
//

import RxCocoa
import RxSwift
import UIKit

class CurrencyConverterViewController: UIViewController {
    @IBOutlet private weak var textFieldView: TextFieldView!
    @IBOutlet private weak var selectCurrencyButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private let presenter: CurrencyConverterPresenter
    private let disposeBag = DisposeBag()
    
    init(currencyConverterInteractor: CurrencyConverterInteractor,
         currencyConverterCoreDataInteractor: CurrencyConverterCoreDataInteractor) {
        self.presenter = CurrencyConverterPresenter(currencyConverterInteractor: currencyConverterInteractor,
                                                    currencyConverterCoreDataInteractor: currencyConverterCoreDataInteractor)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupViews()
        setupTableView()
        bindEvents()
    }
    
    private func setupTitle() {
        title = "Currency Converter"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.magenta]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    private func setupViews() {
        toggleSelectCurrencyButton(isActive: false)
        
        selectCurrencyButton.layer.cornerRadius = 4
        textFieldView.configure(type: .number)
        dissmissKeyboardAfterTap()
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.keyboardDismissMode = .onDrag
        
        let cellIdentifier = "cellIdentifier"
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        presenter.cellViewParams
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { row, viewParam, cell in
                guard let cell = cell as? CurrencyTableViewCell else { return }
                cell.configure(viewParam: viewParam)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CurrencyCellViewParam.self)
            .filter { $0.symbol == "ERR" }
            .subscribe(onNext: { [weak self] viewParam in
                self?.presenter.retryRequest()
            }).disposed(by: disposeBag)
    }
    
    private func bindEvents() {
        textFieldView.rxEventTextChanged
            .subscribe(onNext: { [weak self] text in
                self?.presenter.convertCurrency(text)
            }).disposed(by: disposeBag)
        
        selectCurrencyButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dissmissKeyboard()
                self?.showCurrencySelection()
            }).disposed(by: disposeBag)
        
        presenter.rxEventUpdateButtonText
            .subscribe(onNext: { [weak self] title in
                self?.selectCurrencyButton.setTitle(title, for: .normal)
            }).disposed(by: disposeBag)
        
        presenter.rxEventResetTextField
            .subscribe(onNext: { [weak self] _ in
                self?.textFieldView.reset()
            }).disposed(by: disposeBag)
        
        presenter.rxEventToggleselectCurrencyButton
            .subscribe(onNext: { [weak self] isActive in
                self?.toggleSelectCurrencyButton(isActive: isActive)
            }).disposed(by: disposeBag)
        
        presenter.loadRates()
    }
    
    private func toggleSelectCurrencyButton(isActive: Bool) {
        selectCurrencyButton.backgroundColor = isActive ? .magenta : .lightGray
        selectCurrencyButton.isUserInteractionEnabled = isActive
    }
    
    private func dissmissKeyboardAfterTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    private func showCurrencySelection() {
        let currencyConverterApi = CurrencyConverterApiImpl()
        let currencyConverterCoreData = CurrencyConverterCoreDataImpl()
        
        let currencyConverterCoreDataInteractor = CurrencyConverterCoreDataInteractorImpl(currencyConverterCoreData: currencyConverterCoreData)
        let currencyConverterInteractor = CurrencyConverterInteractorImpl(currencyConverterApi: currencyConverterApi)
        
        let currencySelection = CurrencySelectionViewController(currencyConverterInteractor: currencyConverterInteractor,
                                                                currencyConverterCoreDataInteractor: currencyConverterCoreDataInteractor)
        currencySelection.rxEventCurrencyChanged
            .subscribe(onNext: { [weak self] viewParam in
                self?.presenter.currencyDidChanged(with: viewParam)
            }).disposed(by: disposeBag)
        
        navigationController?.present(currencySelection, animated: true)
    }
}
