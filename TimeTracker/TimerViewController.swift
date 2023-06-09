//
//  TimerViewController.swift
//  TimeTracker
//
//  Created by Artyom Guzenko on 27.05.2023.
//

import UIKit
import SnapKit

class TimerViewController: UIViewController {
    
    // MARK: - Private properties
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Pomodoro"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 84)
        label.textColor = .black
        return label
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.setTitle("Press", for: .normal)
        button.tintColor = UIColor.green
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarch()
        setupView()
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }
}

// MARK: - Private methods
extension TimerViewController {
    private func setupHierarch() {
        view.addSubview(mainLabel)
        view.addSubview(timerLabel)
        view.addSubview(startStopButton)
        
        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayout() {
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(80)
        }
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.centerX.equalTo(view)
        }
        
        startStopButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(60)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

