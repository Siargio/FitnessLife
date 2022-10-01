//
//  CalendarView.swift
//  FitnessLife
//
//  Created by Sergio on 1.10.22.
//

import UIKit

class WeatherView: UIView {

    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.image = UIImage(named: "sun")
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        return weatherImageView
    }()

    private lazy var weatherStatusLabel: UILabel = {
        let weatherStatusLabel = UILabel()
        weatherStatusLabel.text = "Солнечно"
        weatherStatusLabel.font = .robotoMedium18()
        weatherStatusLabel.textColor = .specialGray
        weatherStatusLabel.adjustsFontSizeToFitWidth = true
        weatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherStatusLabel
    }()

    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarcy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarcy() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadowOnView()
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(weatherImageView)
        addSubview(weatherStatusLabel)
        addSubview(weatherDescriptionLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),

            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: 10),
            weatherStatusLabel.heightAnchor.constraint(equalToConstant: 20),

            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 0),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
