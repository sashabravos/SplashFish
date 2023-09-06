//
//  SeaViewController.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class SeaViewController: UIViewController {
    
    // MARK: - Properties
    
    var pointY = 30.0
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
    
    private lazy var fishQueue = DispatchQueue(label: "com.myapp.fishQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addFish()
    }
    
    
    private func setupView() {
        // Set backgroundImageView as backgroundColor
        backgroundImageView.frame = view.frame
        
        [backgroundImageView, restartButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Add fishes
    
    private func addFish() {
        fishQueue.async {
            do {
                try self.addFishes()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func addFishes() throws {
        let fishData: [Fish.FishTypes] = [
            .blackKoi,
            .blackWhiteKoi,
            .orangeKoi,
            .pointedKoi,
            .whiteOrangeKoi,
            .whiteRedKoi,
            .yellowKoi,
            .orangeKoi,
            .blackWhiteKoi,
            .yellowKoi,
            .whiteRedKoi,
            .blackKoi,
            .pointedKoi
        ]
        
        for imageName in fishData {
            sleep(2)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let fish = Fish(view: self.view,
                                imageName: imageName,
                                pointY: pointY)
                fish.startSwimming()
                self.fishes.append(fish)
                pointY += CGFloat.random(in: 50...80)
            }
        }
    }
    
    @objc private func restartAnima() throws {
        if fishes.isEmpty {
            fishQueue.async {
                do {
                    try self.addFishes()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

