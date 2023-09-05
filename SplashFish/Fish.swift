//
//  Fish.swift
//  SplashFish
//
//  Created by Александра Кострова on 05.09.2023.
//

import UIKit

class Fish {
    
    // MARK: - Public Properties
    
    public var isCaught = false
    
    public var fishImageView: UIImageView
    public var isReversed: Bool
    
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
        
        let viewWidth = view.frame.width
        
        self.view = view
        self.imageName = imageName
        self.pointX = CGFloat.random(in: -30...viewWidth - 167)
        self.pointY = pointY
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
        positionAnimation.duration = 20.0
        positionAnimation.toValue = isReversed ? up : down
        positionAnimation.fromValue = isReversed ? down : up
        positionAnimation.repeatCount = .infinity
        
        
//        let animation = CABasicAnimation(keyPath: "position.y")
//        animation.toValue = view.bounds.size.height - pointY
//        animation.duration = 5.0
//        animation.beginTime = CACurrentMediaTime() + 0.3
//        animation.repeatCount = 2
////        animation.autoreverses = true
//        fishImageView.layer.add(animation, forKey: "animation")
//
        fishImageView.layer.add(positionAnimation, forKey: "swimAnimation")

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = -0.1
        rotationAnimation.toValue = 0.05
        rotationAnimation.speed = 0.05
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = .infinity

        fishImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        
        let transformAnimation = CABasicAnimation(keyPath: "transform.rotation")
        transformAnimation.duration = 20.0 // Длительность трансформации должна совпадать с длительностью плавания
        transformAnimation.fromValue = isReversed ? CGFloat.pi : 0
        transformAnimation.toValue = isReversed ? 0 : CGFloat.pi
        transformAnimation.repeatCount = .infinity

        fishImageView.layer.add(transformAnimation, forKey: "transformAnimation")
    }
    
    
    
    func stopSwimming() {
        fishImageView.layer.removeAnimation(forKey: "swimAnimation")
        fishImageView.layer.removeAnimation(forKey: "rotationAnimation")
        fishImageView.layer.removeAnimation(forKey: "transformAnimation")
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
    
        // Анимация появления
    // пружина
//    let springAnimation = CASpringAnimation(keyPath: "transform.scale")
//
//    springAnimation.duration = 5.0
//    springAnimation.fromValue = 0
//    springAnimation.toValue = 1
//
//    fishImageView.layer.add(springAnimation, forKey: "springAnimation")
    
 // появление
//    let animation = CABasicAnimation(keyPath: "opacity")
//    animation.duration = 5.0
//    animation.fromValue = 0
//    animation.toValue = 1
//    fishImageView.layer.add(animation, forKey: "animation")
}
