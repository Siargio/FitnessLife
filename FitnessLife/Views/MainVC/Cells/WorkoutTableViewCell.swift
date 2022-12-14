//
//  WorkoutTableViewCell.swift
//  FitnessLife
//
//  Created by Sergio on 30.09.22.
//

import UIKit

protocol StartWorkoutProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {

    private lazy var backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.textColor = .specialBlack
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var workoutRepsLabel: UILabel = {
       let label = UILabel()
        //label.text = "Reps: 10"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var workoutSetsLabel: UILabel = {
       let label = UILabel()
        //label.text = "Sets: 2"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        //button.setTitle("START", for: .normal)
        button.titleLabel?.font = .robotoBold16()
       // button.tintColor = .specialDarkGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    var labelsStackView = UIStackView()

    var workoutModel = WorkoutModel()

    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?

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
        addSubview(workoutBackgroundView)
        addSubview(workoutImageView)
        addSubview(workoutNameLabel)
        labelsStackView = UIStackView(arrangedSubviews:
                                        [workoutRepsLabel, workoutSetsLabel],
                                        axis: .horizontal,
                                        spacing: 10)
        addSubview(labelsStackView)
        contentView.addSubview(startButton)
    }

    @objc private func startButtonTapped() {
        cellStartWorkoutDelegate?.startButtonTapped(model: workoutModel)
    }

    func cellConfigure(model: WorkoutModel) {
        workoutModel = model
        workoutNameLabel.text = model.workoutName

        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(model.workoutTimer)

        workoutRepsLabel.text = (model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec")
        workoutSetsLabel.text = "Sets: \(model.workoutSets)"

        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData) else { return }
        workoutImageView.image = image

        if model.status {
            startButton.setTitle("COPLITE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
        backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

        workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
        workoutBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
        workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70),

        workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
        workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
        workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
        workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10),

        workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
        workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
        workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),

        labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
        labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
        labelsStackView.heightAnchor.constraint(equalToConstant: 20),

        startButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 5),
        startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
        startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
        startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
