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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addFishes()
    }

    private func setupView() {
        // Set backgroundImageView as backgroundColor
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
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
            fishes.append($0)
        }
    }
}

