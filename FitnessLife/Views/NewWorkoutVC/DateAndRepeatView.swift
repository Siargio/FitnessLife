//
//  File.swift
//  FitnessLife
//
//  Created by Sergio on 1.10.22.
//

import UIKit

class DateAndRepeatView: UIView {

    // MARK: - UIElements
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private lazy var repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat every 7 days"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()

    // MARK: - Setup

    var dateStackView = UIStackView()
    var repeatStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        dateStackView = UIStackView(arrangedSubviews: [dateLabel,datePicker],
                                    axis: .horizontal,
                                    spacing: 10)
        addSubview(dateStackView)

        repeatStackView = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch],
                                      axis: .horizontal,
                                      spacing: 10)
        addSubview(repeatStackView)
    }

    @objc private func dateNumberButtonTapped() {
        print("dateNumberButtonTapped")
    }

    private func setConstraints() {

        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 5),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
