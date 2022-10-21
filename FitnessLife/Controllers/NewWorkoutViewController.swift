//
//  NewWorkutViewController.swift
//  FitnessLife
//
//  Created by Sergio on 1.10.22.
//

import UIKit
import RealmSwift

class NewWorkoutViewController: UIViewController {

    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    private let localRealm = try! Realm()
    private var workoutModel = WorkoutModel()
    private let testImage = UIImage(named: "workoutTestImage")

    // MARK: - UIElements

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delaysContentTouches = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var newWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW WORKOUT"
        label.font = .robotoMedium12()
        label.textColor = .specialGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var nameLabel = UILabel(text: "NameText")

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always // кнопка удалить текст
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let dateAndRepeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Date and repeat"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var repsOrTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps or timer"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Setting

    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        print(dateAndRepeatView.frame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setDelegates()
        addTaps()

    }

    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(scrollView)
        scrollView.addSubview(newWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(dateAndRepeatLabel)
        scrollView.addSubview(dateAndRepeatView)
        scrollView.addSubview(repsOrTimerLabel)
        scrollView.addSubview(repsOrTimerView)
        scrollView.addSubview(saveButton)
    }

    private func setDelegates() {
        nameTextField.delegate = self
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() {
        print("saveButtonTapped")
        setModel()
        saveModel()
    }

    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen) // скрывает клаву если калацть в любом месте

        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func swipeHideKeyboard() {
        view.endEditing(true)
    }

    private func setModel() {
        guard let nameWorkout = nameTextField.text else { return }
        workoutModel.workoutName = nameWorkout

        workoutModel.workoutDate = dateAndRepeatView.datePicker.date.localDate()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.weekday], from: dateAndRepeatView.datePicker.date)
//        guard let weekday = components.weekday else { return }
        workoutModel.workoutNumberOfDay = dateAndRepeatView.datePicker.date.getWeekDayNumber()

        workoutModel.workoutRepeat = (dateAndRepeatView.repeatSwitch.isOn)

        workoutModel.workoutSets = Int(repsOrTimerView.setsSlider.value)
        workoutModel.workoutReps = Int(repsOrTimerView.repsSlider.value)
        workoutModel.workoutTimer = Int(repsOrTimerView.timerSlider.value)

        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }

    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let count = text.filter{ $0.isNumber || $0.isLetter }.count

        if count != 0 && workoutModel.workoutSets != 0 && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            alertOk(title: "Success", message: nil)
            workoutModel = WorkoutModel()
            refreshWorkoutObjects()
        } else {
            alertOk(title: "Error", message: "Enter all parameters")
        }
    }

    private func refreshWorkoutObjects() {
        dateAndRepeatView.datePicker.setDate(Date(), animated: true)
        nameTextField.text = ""
        dateAndRepeatView.repeatSwitch.isOn = true
        repsOrTimerView.numberOfSetLabel.text = "0"
        repsOrTimerView.setsSlider.value = 0
        repsOrTimerView.numberOfRepsLabel.text = "0"
        repsOrTimerView.repsSlider.value = 0
        repsOrTimerView.numberOfTimerLabel.text = "0"
        repsOrTimerView.timerSlider.value = 0
    }
}

//MARK: - NewWorkoutViewController

extension NewWorkoutViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()// скрываем клавиатуру
    }
}

//MARK: - SetConstraints

extension NewWorkoutViewController {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            newWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),

            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38),

            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            //            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 94)
            dateAndRepeatView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),

            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 320),

            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}
