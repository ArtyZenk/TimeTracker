//
//  ViewController.swift
//  TimeTracker
//
//  Created by Artyom Guzenko on 27.05.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // MARK: - Elements
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(circularViewDuration)"
        return label
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.setTitle("Press", for: .normal)
        button.tintColor = UIColor.green
        return button
    }()

    var circularProgressBarView: CircularProgressBarView!
    
    private var circularViewDuration: TimeInterval = 5
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupHierarch()
//        setupView()
        view.backgroundColor = .white
        setUpCircularProgressBarView()
        view.addSubview(timerLabel)
        
        
    }

    override func viewWillLayoutSubviews() {
        timerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view)
        }
    }
}

extension ViewController {
    func setUpCircularProgressBarView() {
            // set view
            circularProgressBarView = CircularProgressBarView(frame: .zero)
            // align to the center of the screen
            circularProgressBarView.center = view.center
       
            // call the animation with circularViewDuration
            circularProgressBarView.progressAnimation(duration: circularViewDuration)
            // add this view to the view controller
            view.addSubview(circularProgressBarView)
        }
}
