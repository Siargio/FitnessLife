//
//  ViewController.swift
//  FitnessLife
//
//  Created by Sergio on 28.09.22.
//

import UIKit

class MainViewController: UIViewController {

    private let calendarView = CalendarView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"

    // MARK: - UIElements

    private lazy var userPhotoImage: UIImageView = {
        let userPhotoImage = UIImageView()
        userPhotoImage.backgroundColor = .systemGray3
        userPhotoImage.layer.borderWidth = 5
        userPhotoImage.layer.borderColor = UIColor.white.cgColor
        userPhotoImage.translatesAutoresizingMaskIntoConstraints = false
        return userPhotoImage
    }()

    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.text = "User"
        userNameLabel.textColor = .specialGray
        userNameLabel.font = .robotoMedium24()
        userNameLabel.adjustsFontSizeToFitWidth = true // уменьшает шрифт в зависимости ширины лейбла
        userNameLabel.minimumScaleFactor = 0.5 // шрифт делит на половину если много текста
        //userNameLabel.numberOfLines = 2 // количество строк
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()

    private lazy var addWorkoutButton: UIButton = {
        let addWorkoutButton = UIButton(type: .system)
        addWorkoutButton.backgroundColor = .specialYellow
        addWorkoutButton.layer.cornerRadius = 10
        addWorkoutButton.setTitle("Add workout", for: .normal)
        addWorkoutButton.titleLabel?.font = .robotoMedium12()
        addWorkoutButton.tintColor = .specialDarkGreen
        addWorkoutButton.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                        left: 20,
                                                        bottom: 15,
                                                        right: 0)
        addWorkoutButton.titleEdgeInsets = UIEdgeInsets(top: 50,
                                                        left: -40,
                                                        bottom: 0,
                                                        right: 0)
        addWorkoutButton.setImage(UIImage(named: "addWorkout"), for: .normal)
        addWorkoutButton.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        addWorkoutButton.addShadowOnView()
        addWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        return addWorkoutButton
    }()

    private lazy var workoutTodayLabel: UILabel = {
        let workoutTodayLabel = UILabel()
        workoutTodayLabel.text = "Workout today"
        workoutTodayLabel.textColor = .specialLightBrown
        workoutTodayLabel.font = .robotoMedium14()
        workoutTodayLabel.translatesAutoresizingMaskIntoConstraints = false
        return workoutTodayLabel
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false // скрол
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLayoutSubviews() {
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.width / 2
    }

    // MARK: - Setting

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
        setDelegate()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
    }

    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupHierarchy() {
        view.backgroundColor = .specialBackground
        view.addSubview(calendarView)
        view.addSubview(userPhotoImage)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
    }

    // MARK: - Action

    @objc private func addWorkoutButtonTapped() {
        print("addWorkoutButtonTapped")
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as? WorkoutTableViewCell
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - Set constraints

extension MainViewController {

    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImage.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImage.widthAnchor.constraint(equalToConstant: 100),

            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),

            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImage.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),

            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
