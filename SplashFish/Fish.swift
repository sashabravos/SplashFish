//
//  Fish.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class Fish {
    
    // MARK: - Public Properties
    
    public var fishImageView: UIImageView
    public var isCaught = false
    
    // MARK: - Enums
    
    enum FishActions {
        case left, right, up, down
    }
    
    enum FishTypes {
        case blackKoi, blackWhiteKoi,
             orangeKoi, pointedKoi,
             whiteOrangeKoi, whiteRedKoi, yellowKoi
    }
    
    // MARK: - Private Properties
    
    private var view: UIView
    private var pointX: CGFloat
    private var pointY: CGFloat
    private var imageName: FishTypes
    
    // MARK: - Initialisation
    
    init(view: UIView,
         imageName: FishTypes,
         pointY: CGFloat) {
        
//        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        
        self.view = view
        self.imageName = imageName
        self.pointX = CGFloat.random(in: -30...viewWidth - 167)
        self.pointY = pointY
        
        var image: UIImage?
        
        switch imageName {
        case .blackKoi:
            image = UIImage(named: "blackKoi")
        case .blackWhiteKoi:
            image = UIImage(named: "blackWhiteKoi")
        case .orangeKoi:
            image = UIImage(named: "orangeKoi")
        case .pointedKoi:
            image = UIImage(named: "pointedKoi")
        case .whiteOrangeKoi:
            image = UIImage(named: "whiteOrangeKoi")
        case .whiteRedKoi:
            image = UIImage(named: "whiteRedKoi")
        case .yellowKoi:
            image = UIImage(named: "yellowKoi")
        }
        
        guard let fishImage = image else {
            fatalError("Image not found for imageName: \(imageName)")
        }
        
        fishImageView = UIImageView(image: fishImage)
        fishImageView.frame = CGRect(x: pointX, y: pointY, width: 200, height: 200)
        fishImageView.contentMode = .scaleAspectFit
        view.addSubview(fishImageView)
    }
    
    // MARK: - Public Methods
    
    public func fishCaughtAnimation(fish: Fish) {
        isCaught = true
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            fish.fishImageView.alpha = 0
        }) { _ in
            fish.fishImageView.removeFromSuperview()
        }
    }
}
