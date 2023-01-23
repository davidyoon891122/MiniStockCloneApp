//
//  PasswordPresentationController.swift
//  TestApp
//
//  Created by Jiwon Yoon on 2023/01/21.
//

import UIKit

final class PasswordPresentationController: UIPresentationController {
    let blurEffectView: UIVisualEffectView!
    var tapGestureReconizer: UITapGestureRecognizer = UITapGestureRecognizer()

    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
        tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.addGestureRecognizer(tapGestureReconizer)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(
            origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.4),
            size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height)
        )
    }

    override func presentationTransitionWillBegin() {
        blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22.0)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
}

private extension PasswordPresentationController {
    @objc
    func dismissController() {
        presentedViewController.dismiss(animated: true)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
