//
//  HomeVC.swift
//  BankSampleApp
//
//  Created by Daniel Filho on 30/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // UI Elements
    let stackView = UIStackView()
    let limitAmountTitle = UILabel()
    let limitAmountControl = UISegmentedControl(items: ["500", "1000", "5000", "10000", "50000"])
    let stepAmountTitle = UILabel()
    let stepAmountControl = UISegmentedControl(items: ["1", "100", "200", "500", "1000"])
    let dailyPeriodTitle = UILabel()
    let dailyPeriodControl = UISegmentedControl(items: ["Daytime", "Nighttime"])
    let limitType = UILabel()
    let limitTypeControl = UISegmentedControl(items: ["Everyone", "Trusted", "Change"])
    let limitCardView = UIStackView()
    let editLimitButton = UIButton()
    
    var stepAmount: Float = 0
    var maximumLimit: Float = 0
    var dailyPeriod: String = ""
    var limitName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureStackView()
        configureEditButton()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 18
        
        stackView.addArrangedSubview(dailyPeriodTitle)
        dailyPeriodTitle.text = "Daily Period"
        dailyPeriodTitle.font = .preferredFont(forTextStyle: .headline)
        
        stackView.addArrangedSubview(dailyPeriodControl)
        dailyPeriodControl.selectedSegmentIndex = 0
        
        stackView.addArrangedSubview(limitType)
        limitType.text = "Limit Type"
        limitType.font = .preferredFont(forTextStyle: .headline)
        
        stackView.addArrangedSubview(limitTypeControl)
        limitTypeControl.selectedSegmentIndex = 0
        
        stackView.addArrangedSubview(limitAmountTitle)
        limitAmountTitle.text = "Maximum Limit Amount"
        limitAmountTitle.font = .preferredFont(forTextStyle: .headline)
        
        stackView.addArrangedSubview(limitAmountControl)
        limitAmountControl.selectedSegmentIndex = 0
        
        stackView.addArrangedSubview(stepAmountTitle)
        stepAmountTitle.text = "Step Amount"
        stepAmountTitle.font = .preferredFont(forTextStyle: .headline)
        
        stackView.addArrangedSubview(stepAmountControl)
        stepAmountControl.selectedSegmentIndex = 0
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setMaximumLimitAmount(){
        let selectedAmount = limitAmountControl.titleForSegment(at: limitAmountControl.selectedSegmentIndex)
        self.maximumLimit = Float(selectedAmount!) ?? 1000
    }
    
    func setStepAmount(){
        let selectedAmount = stepAmountControl.titleForSegment(at: stepAmountControl.selectedSegmentIndex)
        stepAmount = Float(selectedAmount!) ?? 1
    }
    
    func setDailyPeriod() {
        let selectedPeriod = dailyPeriodControl.titleForSegment(at: dailyPeriodControl.selectedSegmentIndex)!
        self.dailyPeriod = selectedPeriod
    }
    
    func setLimitName() {
        self.limitName = limitTypeControl.titleForSegment(at: limitTypeControl.selectedSegmentIndex)!
    }
    
    func configureEditButton() {
        view.addSubview(editLimitButton)
        editLimitButton.translatesAutoresizingMaskIntoConstraints = false
        editLimitButton.addTarget(self, action: #selector(openEditScreen), for: .touchUpInside)
        
        editLimitButton.setTitle("Edit Limit", for: .normal)
        editLimitButton.backgroundColor = .label
        editLimitButton.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            editLimitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editLimitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editLimitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editLimitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc func openEditScreen() {
        navigationController?.modalPresentationStyle = .formSheet
        
        setMaximumLimitAmount()
        setStepAmount()
        setDailyPeriod()
        setLimitName()
        
        present(EditLimitViewController(maxLimitAmount: self.maximumLimit, stepAmount: self.stepAmount, dailyPeriod: self.dailyPeriod, limitName: self.limitName), animated: true)
    }
}
