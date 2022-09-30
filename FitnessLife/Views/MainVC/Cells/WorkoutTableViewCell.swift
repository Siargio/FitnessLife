//
//  WorkoutTableViewCell.swift
//  FitnessLife
//
//  Created by Sergio on 30.09.22.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(backgroundCell)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
        backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
        backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
