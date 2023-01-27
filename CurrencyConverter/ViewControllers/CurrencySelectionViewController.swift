//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import RxCocoa
import RxSwift
import UIKit

class CurrencySelectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textFieldView: TextFieldView!
    
    private let presenter: CurrencySelectionPresenter
    
    private let eventCurrencyChanged = PublishSubject<CurrencyCellViewParam>()
    var rxEventCurrencyChanged: Observable<CurrencyCellViewParam> {
        return eventCurrencyChanged
    }
    private let disposeBag = DisposeBag()
    
    init(currencyConverterInteractor: CurrencyConverterInteractor) {
        self.presenter = CurrencySelectionPresenter(currencyConverterInteractor: currencyConverterInteractor)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        bindEvents()
    }
    
    private func setupViews() {
        textFieldView.configure(type: .search)
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
    }
    
    private func bindEvents() {
        textFieldView.rxEventTextChanged
            .subscribe(onNext: { [weak self] text in
                self?.presenter.filterSymbols(with: text)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CurrencyCellViewParam.self)
            .subscribe(onNext: { [weak self] viewParam in
                self?.presenter.didSelectRow(viewParam: viewParam)
            }).disposed(by: disposeBag)
        
        presenter.rxEventDidSelectRow
            .subscribe(onNext: { [weak self] viewParam in
                self?.eventCurrencyChanged.onNext(viewParam)
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        presenter.loadSymbols()
    }
}
