//
//  TransitionManager.swift
//  test
//
//  Created by Swifter on 15/12/22.
//  Copyright © 2015年 Unknown. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        toView.transform = CGAffineTransformMakeScale(0.3, 0.3)
        container!.addSubview(fromView)
        container!.addSubview(toView)

        let circleMaskPathInitial = UIBezierPath(ovalInRect: toView.frame)
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(toView.frame, -UIScreen.mainScreen().bounds.size.height, -UIScreen.mainScreen().bounds.size.height))
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toView.layer.mask = maskLayer

        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        
        let duration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: [], animations: {
            fromView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: { finished in
                transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
