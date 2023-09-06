//
//  SeaViewController.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class SeaViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var pointY = Constants.Origin.topOffset
    private lazy var fishes: [Fish] = []
    private lazy var fishQueue = DispatchQueue(label: Constants.QueueNames.fishQueue)
    
    // MARK: - UI Elements
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.backImage
        return view
    }()
    
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Images.replay
            .withTintColor(Constants.Colors.replayNormal),
                        for: .normal)
        button.setImage(Constants.Images.replay
            .withTintColor(Constants.Colors.replaySelected),
                        for: .selected)
        button.addTarget(self, action: #selector(restartAnima), for: .touchUpInside)
        button.frame = CGRect(x: Constants.Origin.replayButtonX,
                              y: Constants.Origin.replayButtonY,
                              width: Constants.Sizes.replayButton,
                              height: Constants.Sizes.replayButton)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addFish()
        addGestures()
    }
    
    // MARK: - View's setting
    
    private func setupView() {
        // Set backgroundImageView as backgroundColor
        backgroundImageView.frame = view.frame
        
        [backgroundImageView, restartButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Add fishes
    
    private func addFish() {
        fishQueue.async { [weak self] in
            guard let self = self else { return }
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
        
        fishData.forEach { imageName in
            sleep(2)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let fish = Fish(view: self.view,
                                imageName: imageName,
                                pointY: self.pointY)
                self.fishes.append(fish)
                self.pointY += Constants.Origin.verticalStep
            }
        }
    }
    
    
    
    // MARK: - Add Actions
    
    @objc private func restartAnima() {
        if !fishes.isEmpty {
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.fishes.forEach { fish in
                    fish.fishCaughtAnimation(fish: fish)
                }
                fishes.removeAll()
            }
        } else {
            addFish()
        }
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        
        fishes.forEach { fish in
            if (fish.fishImageView.layer.presentation()?.frame.contains(tapLocation))! {
                if fish.isCaught { return }
                fish.isCaught = true
                fish.fishCaughtAnimation(fish: fish)
                return
            }
        }
    }
}

