//
//  ViewController.swift
//  FitnessLife
//
//  Created by Sergio on 28.09.22.
//

import UIKit

class MainViewController: UIViewController {

    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"

    // MARK: - UIElements

    private lazy var userPhotoImageView: UIImageView = {
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
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.isHidden = true
        return tableView
    }()

    private lazy var noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleToFill
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    // MARK: - Setting

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
        setDelegate()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
    }

    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupHierarchy() {
        view.backgroundColor = .specialBackground
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
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
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),

            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),

            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),

            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80),

            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor)
        ])
    }
}
