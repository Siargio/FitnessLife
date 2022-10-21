//
//  CalendarCollectionViewCell.swift
//  FitnessLife
//
//  Created by Sergio on 28.09.22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    private lazy var dayOfWeekLabel: UILabel = {
        let dayOfWeekLabel = UILabel()
        dayOfWeekLabel.text = "We"
        dayOfWeekLabel.font = .robotoMedium16()
        dayOfWeekLabel.textColor = .white
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayOfWeekLabel
    }()

    let numberOfDayLabel: UILabel = {
        let dayOfWeekLabel = UILabel()
        dayOfWeekLabel.text = "29"
        dayOfWeekLabel.font = .robotoMedium20()
        dayOfWeekLabel.textColor = .white
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayOfWeekLabel
    }()

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                backgroundColor = .specialGreen
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }

    func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLabel.text = numberOfDay
        dayOfWeekLabel.text = dayOfWeek
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),

            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
