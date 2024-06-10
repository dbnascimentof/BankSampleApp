//
//  EditLimitViewController.swift
//  BankSampleApp
//
//  Created by Daniel Filho on 31/05/24.
//

import UIKit

class EditLimitVC: UIViewController {

    // UI elements
    let cancelButton = UIButton()
    let limitIcon = UIImageView()
    let limitPeriod = UILabel()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    let totalLabel = UILabel()
    let totalLimitAmountLabel = UILabel()
    let totalLimitSlider = UISlider()
    
    let perTransactionTotalLabel = UILabel()
    let perTransactionLimitAmountLabel = UILabel()
    let perTransactionSlider = UISlider()
    
    let saveButton = UIButton()
    
    // Limit properties
    var stepAmount: Float = 1
    var maxLimitAmount: Float = 0
    var dailyPeriod: String = ""
    var limitName: String = ""
    
    init(maxLimitAmount: Float, stepAmount: Float, dailyPeriod: String, limitName: String) {
        super.init(nibName: nil, bundle: nil)
        self.stepAmount = stepAmount
        self.maxLimitAmount = maxLimitAmount
        self.dailyPeriod = dailyPeriod
        self.limitName = limitName
        
        // Setting Up UI Elements
        setupModalHeader()
        setupIconAndPeriod()
        setupTitleAndSubtitle()
        configureSaveButton()
        setupLimitSlider()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    /* MARK: Top of the screen: cancel button */
    func setupModalHeader() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.label, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc func closeModal(){
        dismiss(animated: true)
    }
    
    /* MARK: Top of the screen: Icon and timeslot */
    func setupIconAndPeriod() {
        limitIcon.contentMode = .scaleAspectFit
        limitIcon.translatesAutoresizingMaskIntoConstraints = false 
        view.addSubview(limitIcon)
        
        limitPeriod.font = .preferredFont(forTextStyle: .body)
        limitPeriod.textAlignment = .center
        limitPeriod.layer.cornerRadius = 16
        limitPeriod.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(limitPeriod)
        
        NSLayoutConstraint.activate([
            limitIcon.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20),
            limitIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            limitIcon.heightAnchor.constraint(equalToConstant: 48),
            limitIcon.widthAnchor.constraint(equalToConstant: 48),
            limitPeriod.topAnchor.constraint(equalTo: limitIcon.bottomAnchor, constant: 10),
            limitPeriod.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            limitPeriod.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // TODO: Move this part of the code to a specialized function.
        if self.dailyPeriod == "Daytime" {
            limitPeriod.text = "6:00AM - 7:59PM"
        } else {
            limitPeriod.text = "8:00PM - 5:59AM"
        }
        
        switch self.limitName {
        case "Everyone":
            titleLabel.text = "Set your transfer limits"
            limitIcon.image = UIImage(named: "Contact Picker")
        case "Trusted":
            titleLabel.text = "Set your trusted recipients' limits"
            limitIcon.image = UIImage(named: "Secure")
        default:
            titleLabel.text = "Set your change & withdrawal limits"
            limitIcon.image = UIImage(named: "atm")
        }
    }

    /* MARK: Middle of the screen: Title and subtitle */
    func setupTitleAndSubtitle() {
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subTitleLabel.text = "Increases are subjected to approvals within 48 hours, decreases are instant"
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = .preferredFont(forTextStyle: .body)
        subTitleLabel.numberOfLines = 2
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleLabel)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: limitPeriod.bottomAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupLimitSlider() {
        switch self.limitName {
        case "Trusted":
            setupTotalSlider()
        default:
            setupPerTransactionSlider()
        }
    }
    
    
    func setupTotalSlider(){
        // Horizontal Stackview to control Limit Total and Amount
        let totalLimitSV = UIStackView()
        totalLimitSV.axis = .horizontal
        totalLimitSV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalLimitSV)
        
        totalLabel.text = "Total"
        totalLabel.font = .systemFont(ofSize: 14)
        totalLimitSV.addArrangedSubview(totalLabel)

        totalLimitAmountLabel.text = "R$ 0.00"
        totalLimitAmountLabel.font = .systemFont(ofSize: 16, weight: .bold)
        totalLimitSV.addArrangedSubview(totalLimitAmountLabel)
        
        //Total Slider configuration
        totalLimitSlider.minimumValue = 0
        totalLimitSlider.maximumValue = self.maxLimitAmount
        totalLimitSlider.tintColor = .systemGreen
        totalLimitSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalLimitSlider)
        
        totalLimitSlider.addTarget(self, action: #selector(updateTotalLimitAmountLabel), for: .touchDragInside)
        
        NSLayoutConstraint.activate([
            totalLimitSV.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            totalLimitSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalLimitSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            totalLimitSlider.topAnchor.constraint(equalTo: totalLimitSV.bottomAnchor, constant: 10),
            totalLimitSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalLimitSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func updateTotalLimitAmountLabel() {
        let roundedValue = round(totalLimitSlider.value / stepAmount) * stepAmount
        totalLimitAmountLabel.text = "R$ \(String(format: "%.2f", roundedValue))"
    }
    
    
    func setupPerTransactionSlider(){
        setupTotalSlider()
        
        // Horizontal Stackview to control Limit Total and Amount
        let perTransactionLimitSV = UIStackView()
        perTransactionLimitSV.axis = .horizontal
        perTransactionLimitSV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(perTransactionLimitSV)
        
        perTransactionTotalLabel.text = "Per Transaction"
        perTransactionTotalLabel.font = .systemFont(ofSize: 14)
        perTransactionLimitSV.addArrangedSubview(perTransactionTotalLabel)

        perTransactionLimitAmountLabel.text = "R$ 0.00"
        perTransactionLimitAmountLabel.font = .systemFont(ofSize: 16, weight: .bold)
        perTransactionLimitSV.addArrangedSubview(perTransactionLimitAmountLabel)
        
        //Total Slider configuration
        perTransactionSlider.minimumValue = 0
        perTransactionSlider.maximumValue = self.maxLimitAmount
        perTransactionSlider.tintColor = .systemGreen
        perTransactionSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(perTransactionSlider)
        
        perTransactionSlider.addTarget(self, action: #selector(updatePerTransactionLimitAmountLabel), for: .touchDragInside)
        
        NSLayoutConstraint.activate([
            perTransactionLimitSV.topAnchor.constraint(equalTo: totalLimitSlider.bottomAnchor, constant: 20),
            perTransactionLimitSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            perTransactionLimitSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            perTransactionSlider.topAnchor.constraint(equalTo: perTransactionLimitSV.bottomAnchor, constant: 10),
            perTransactionSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            perTransactionSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    

    @objc func updatePerTransactionLimitAmountLabel() {
        let sliderStep = round(perTransactionSlider.value / stepAmount) * stepAmount
        perTransactionLimitAmountLabel.text = "R$ \(String(format: "%.2f", sliderStep))"
    }
    
    
    func configureSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.layer.cornerRadius = 12
        saveButton.backgroundColor = .black
        saveButton.tintColor = .white
        saveButton.setTitle("Save", for: .normal)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
