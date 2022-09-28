//
//  CalendarView.swift
//  FitnessLife
//
//  Created by Sergio on 28.09.22.
//

import UIKit

class CalendarView: UIView {

    private let idCalendarCell = "idCalendarCell"

    // MARK: - UIElements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupConstraints()
        setDelegates()

        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(collectionView)
    }

    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: - UICollectionViewDelegate

extension CalendarView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionViewTap")
    }
}

//MARK: - UICollectionViewDataSource

extension CalendarView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as! CalendarCollectionViewCell
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 7.9,
              height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}

//MARK: - SetConstraints

extension CalendarView {

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
