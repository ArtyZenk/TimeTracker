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
        label.text = "\(durationWorkTimer)"
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
    
    // MARK: - Timer properties
    private var timer = Timer()
    
    private let workTime = 10
    private let relaxTime = 5
    
    private var durationWorkTimer = 10
    private var durationRelaxTimer = 5
    
    private var isStarted = false
   
    private enum WorkingMode {
        case isWorkingMode, isRelaxMode
    }
    
    private var currentMode = WorkingMode.isWorkingMode
    
    // MARK: - CAShapeLayer properties
    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarch()
        setupView()
        setCircularAnimation(color: UIColor.black.cgColor)
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }

    @objc private func startStopButtonPressed() {
        
        if isStarted && (durationWorkTimer != 0 || durationRelaxTimer != 0) {
            timer.invalidate()
            isStarted.toggle()
//            durationWorkTimer = durationWorkTimer - (workTime - durationWorkTimer)
            return
        }
        
        switch currentMode {
        case .isWorkingMode:
            startStopButton.setTitle("Relax", for: .normal)
            timerLabel.text = "\(durationWorkTimer)"
            
            setCircularAnimation(color: UIColor.red.cgColor)
            
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(setTimerForWork),
                                         userInfo: nil,
                                         repeats: true)
            
            isStarted.toggle()
            setBasicAnimation(with: durationWorkTimer)
            
            
            currentMode = .isRelaxMode
        case .isRelaxMode:
            startStopButton.setTitle("Work", for: .normal)
            timerLabel.text = "\(durationRelaxTimer)"

            
            setCircularAnimation(color: UIColor.green.cgColor)
            
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(setTimerForRelax),
                                         userInfo: nil,
                                         repeats: true)
            isStarted.toggle()

            setBasicAnimation(with: durationRelaxTimer)
            
            currentMode = .isWorkingMode
        }
        
       
    }
    
    // MARK: - Timer methods
    @objc private func setTimerForWork() {
        durationWorkTimer -= 1
        timerLabel.text = "\(durationWorkTimer)"


        
        if durationWorkTimer == 0 {
            timer.invalidate()
            durationWorkTimer = 10
            timerLabel.text = "\(durationWorkTimer)"
        }
    }
    
    @objc private func setTimerForRelax() {
        durationRelaxTimer -= 1
        timerLabel.text = "\(durationRelaxTimer)"
    
        
        if durationRelaxTimer == 0 {
            timer.invalidate()
            durationRelaxTimer = 5
        }
    }
    
    // MARK: - Animation
    private func setCircularAnimation(color: CGColor?) {
        
        let center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
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
        shapeLayer.strokeColor = color
        
        view.layer.addSublayer(shapeLayer)
    }
    
    private func setBasicAnimation(with time: Int) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.duration = CFTimeInterval(time)
        basicAnimation.toValue = 0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

// MARK: - Private methods
extension TimerViewController {
    private func setupHierarch() {
        view.addSubview(mainLabel)
        view.addSubview(timerLabel)
        view.addSubview(startStopButton)
        
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
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.centerX.equalTo(view)
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

