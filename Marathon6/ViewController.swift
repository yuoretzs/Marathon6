//
//  ViewController.swift
//  Marathon6
//
//  Created by юра on 16.03.23.
//

import UIKit


class ViewController: UIViewController {
    
    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createGestureRecognizer()
        createSmallSquareView()
        createAnimatorAndBehaviours()
    }
    
    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    func createSmallSquareView() {
        let squareSize: CGFloat = 100
        let squareOrigin = CGPoint(x: (view.frame.width - squareSize) / 2, y: (view.frame.height - squareSize) / 2)
        squareView = UIView(frame: CGRect(origin: squareOrigin, size: CGSize(width: squareSize, height: squareSize)))
        squareView.backgroundColor = .blue
        view.addSubview(squareView)
    }
    
    func createAnimatorAndBehaviours() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
    
    @objc func handleTap(patamTap: UITapGestureRecognizer) {
        
        let tapPoint = patamTap.location(in: view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
}
