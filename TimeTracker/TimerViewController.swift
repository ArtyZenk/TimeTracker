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
    
    private lazy var shapeView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "circle")
        return image
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont.boldSystemFont(ofSize: 75)
        label.textColor = .black
        return label
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        return button
    }()
    
    private var timer = Timer()
    
    private var durationTimer = 10

    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarch()
        setupView()
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        setCircularAnimation()
    }
    
    @objc private func startStopButtonPressed() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(setTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // MARK: - Timer methods
    @objc private func setTimer() {
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        
        if durationTimer == 0 {
            timer.invalidate()
        }
    }
    
    // MARK: - Animation
    
    private func setCircularAnimation() {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngle = -CGFloat.pi / 2
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 138,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
}

// MARK: - Private methods
extension TimerViewController {
    private func setupHierarch() {
        view.addSubview(mainLabel)
        view.addSubview(shapeView)
        view.addSubview(startStopButton)
        
        shapeView.addSubview(timerLabel)
        
        startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)

        view.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayout() {
        mainLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(80)
        }
        
        shapeView.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.centerX.equalTo(view)
            $0.width.equalTo(300)
            $0.height.equalTo(300)
        }
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(shapeView)
            $0.centerX.equalTo(shapeView)
        }
        
        startStopButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(-80)
            $0.width.equalTo(300)
            $0.height.equalTo(60)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

