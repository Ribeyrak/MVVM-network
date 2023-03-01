//
//  MainVC.swift
//  Acrch
//
//  Created by Evhen Lukhtan on 21.02.2023.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    // MARK: - Variables
    var lowerToPass: String?
    var upperToPass: String?
    
    // MARK: - UI
    private let lowerBoundTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Lower bound"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private let upperBoundTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Upper bound"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemGray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let paginationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pagination by 10", for: .normal)
        button.addTarget(self, action: #selector(didTapPaginationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifececycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.backgroundColor = .white
                
        view.addSubview(lowerBoundTextField)
        lowerBoundTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-60)
            $0.left.equalToSuperview().inset(30)
            $0.width.equalTo(220)
            $0.height.equalTo(40)
        }
        view.addSubview(upperBoundTextField)
        upperBoundTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(30)
            $0.width.equalTo(220)
            $0.height.equalTo(40)
        }
        view.addSubview(submitButton)
        submitButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-30)
            $0.left.equalTo(upperBoundTextField.snp.right).offset(30)
            $0.height.equalTo(100)
            $0.width.equalTo(80)
        }
        
        view.addSubview(paginationButton)
        paginationButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(upperBoundTextField.snp.bottom).offset(30)
        }
    }
    
    // MARK: - Actions
    @objc func textFieldDidChange() {
        if let text1 = lowerBoundTextField.text, !text1.isEmpty,
           let text2 = upperBoundTextField.text, !text2.isEmpty {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    @objc func didTapPaginationButton() {
//        let buttonType: ButtonType = .pagination
//        let vc = ViewController()
//        vc.buttonType = buttonType
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSubmitButton() {
        let buttonType: ButtonType = .submit
        let vc = ViewController(lower: lowerBoundTextField.text ?? "", upper: upperBoundTextField.text ?? "")
        vc.buttonType = buttonType
        navigationController?.pushViewController(vc, animated: true)
    }

}
