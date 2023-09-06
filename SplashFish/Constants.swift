//
//  Constants.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

enum Constants {
     
    // MARK: - Images

    enum Images {
        static let backImage = UIImage(named: "backgroundImage") ?? UIImage()
        static let replay = UIImage(named: "replay") ?? UIImage()
        
        static let blackKoi = UIImage(named: "blackKoi")
        static let blackWhiteKoi = UIImage(named: "blackWhiteKoi")
        static let orangeKoi = UIImage(named: "orangeKoi")
        static let pointedKoi = UIImage(named: "pointedKoi")
        static let whiteOrangeKoi = UIImage(named: "whiteOrangeKoi")
        static let whiteRedKoi = UIImage(named: "whiteRedKoi")
        static let yellowKoi = UIImage(named: "yellowKoi")
    }
    
    // MARK: - Names

    enum QueueNames {
        static let fishQueue = "splashFish.fishQueue"
    }
    
    // MARK: - Colors

    enum Colors {
        static let replayNormal = #colorLiteral(red: 0.5411764706, green: 0.7450980392, blue: 0.9843137255, alpha: 1)
        static let replaySelected = #colorLiteral(red: 0.9232581258, green: 0.9782307744, blue: 0.9471222758, alpha: 1)
    }

    // MARK: - Frame
    
    enum Sizes {
        static let fishImage = 200.0
        static let replayButton = 100.0
    }
    
    enum Origin {
        static let leftOffset = -30.0
        static let rightOffset = -167.0
        static let topOffset = 30.0
        static let verticalStep = CGFloat.random(in: 50...80)
        
        static let replayButtonX = 280.0
        static let replayButtonY = 710.0
    }
    
    // MARK: - Animation

    enum Durations {
        static let swim = 5.0
        static let hide = 0.3
    }
    
    enum AnimationKeyName {
        static let swim = "swimAnimation"
    }
    
    enum CAKeyPath {
        static let positionY = "position.y"
    }
}
