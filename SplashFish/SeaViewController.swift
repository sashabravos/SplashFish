//
//  SeaViewController.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class SeaViewController: UIViewController {
    
    // MARK: - Properties

    private lazy var fishes: [Fish] = []

    // MARK: - UI Elements

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.backImage
        return view
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "replay")?.withTintColor(.white), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30.0, weight: .semibold)
        button.addTarget(self, action: #selector(restartAnima), for: .touchUpInside)
        button.frame = CGRect(x: 280,
                              y: 710,
                                     width: 100, height: 100)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addFishes()
    }

    
    private func setupView() {
        // Set backgroundImageView as backgroundColor
        backgroundImageView.frame = view.frame
        
        [backgroundImageView, restartButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Add fishes

    private func addFishes() {
        let fish1 = Fish(view: view,
                         imageName: .blackKoi,
                         pointY: 30.0)
        
        let fish2 = Fish(view: view,
                         imageName: .blackWhiteKoi,
                         pointY: 140.0)
        
        let fish3 = Fish(view: view,
                         imageName: .orangeKoi,
                         pointY: 250.0)

        let fish4 = Fish(view: view,
                         imageName: .pointedKoi,
                         pointY: 360.0)

        let fish5 = Fish(view: view,
                         imageName: .whiteOrangeKoi,
                         pointY: 470.0)

        let fish6 = Fish(view: view,
                         imageName: .whiteRedKoi,
                         pointY: 580.0)
        
        let fish7 = Fish(view: view,
                         imageName: .yellowKoi,
                         pointY: 650)
        
        [fish1, fish2, fish3, fish4, fish5, fish6, fish7].forEach {
            $0.startSwimming()
            fishes.append($0)
        }
    }
    
    @objc private func restartAnima() {
        fishes.forEach {
            $0.startSwimming()
        }
    }
}

