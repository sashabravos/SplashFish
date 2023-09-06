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
        self.pointX = CGFloat.random(
            in: Constants.Origin.leftOffset...viewWidth - Constants.Origin.rightOffset)
        self.isReversed = Bool.random()

        
        var image: UIImage?
        
        switch imageName {
        case .blackKoi:
            image = Constants.Images.blackKoi
        case .blackWhiteKoi:
            image = Constants.Images.blackWhiteKoi
        case .orangeKoi:
            image = Constants.Images.orangeKoi
        case .pointedKoi:
            image = Constants.Images.pointedKoi
        case .whiteOrangeKoi:
            image = Constants.Images.whiteOrangeKoi
        case .whiteRedKoi:
            image = Constants.Images.whiteRedKoi
        case .yellowKoi:
            image = Constants.Images.yellowKoi
        }
        
        guard let fishImage = image else {
            fatalError("Image not found for imageName: \(imageName)")
        }
        
        fishImageView = UIImageView(image: fishImage)
        fishImageView.frame = CGRect(x: pointX, y: pointY,
                                     width: Constants.Sizes.fishImage,
                                     height: Constants.Sizes.fishImage)
        
        fishImageView.contentMode = .scaleAspectFit
        view.addSubview(fishImageView)
        startSwimming()
    }
    
    // MARK: - Private Methods
    
    private func startSwimming() {

        let up = pointY - view.frame.height
        let down = pointY + view.frame.height
        let positionAnimation = CABasicAnimation(keyPath: Constants.CAKeyPath.positionY)
        positionAnimation.duration = Constants.Durations.swim
        positionAnimation.fromValue = isReversed ? up : down
        positionAnimation.toValue = isReversed ? down : up
        positionAnimation.repeatCount = .infinity

        fishImageView.layer.add(positionAnimation, forKey: Constants.AnimationKeyName.swim)

        fishImageView.transform = isReversed ?  CGAffineTransform(rotationAngle: CGFloat.pi).inverted() : .identity
    }
    
    func stopSwimming() {
        fishImageView.layer.removeAnimation(forKey: Constants.AnimationKeyName.swim)
    }
    
    // MARK: - Public Methods
    
    public func fishCaughtAnimation(fish: Fish) {
        isCaught = true
        UIView.animate(withDuration: Constants.Durations.hide,
                       delay: .zero,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
            fish.fishImageView.alpha = .zero
        }) { _ in
            fish.fishImageView.removeFromSuperview()
        }
    }
}
