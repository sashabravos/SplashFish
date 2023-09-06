//
//  Fish.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class Fish {
    
    // MARK: - Public Properties
    
    public lazy var isCaught = false

    public var fishImageView: UIImageView
    public var isReversed: Bool
    public var pointY: CGFloat
    
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
    private var imageName: FishTypes
    
    // MARK: - Initialisation
    
    init(view: UIView,
         imageName: FishTypes,
         pointY: CGFloat) {
        
        let viewWidth = view.frame.width
        
        self.view = view
        self.imageName = imageName
        self.pointY = pointY
        self.pointX = CGFloat.random(in: -30...viewWidth - 167)
        self.isReversed = Bool.random()

        
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
    
    // MARK: - Private Methods
    
    func startSwimming() {

        let up = pointY - view.frame.height
        let down = pointY + view.frame.height
//        let down2 = view.bounds.size.height - pointY
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.duration = 5.0
        positionAnimation.fromValue = isReversed ? up : down
        positionAnimation.toValue = isReversed ? down : up
        positionAnimation.repeatCount = .infinity

        fishImageView.layer.add(positionAnimation, forKey: "swimAnimation")

        fishImageView.transform = isReversed ?  CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
    
    
    
    func stopSwimming() {
        fishImageView.layer.removeAnimation(forKey: "swimAnimation")
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
