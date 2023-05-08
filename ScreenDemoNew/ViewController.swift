//
//  ViewController.swift
//  ScreenDemoNew
//
//  Created by Pankaj Yadav on 05/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    var mainView:UIView={
        let view = UIView()
          view.backgroundColor = .white
         view.isUserInteractionEnabled = true
         view.clipsToBounds = true
         return view
    }()
    
    var view1:UIView={
       let view = UIView()
        //view.backgroundColor = .white
        //view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    var view2:UIView={
       let view = UIView()
        //view.backgroundColor = .white
        //view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    var image1:UIImageView={
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleToFill
        //image.image = UIImage(named: "View3.1")
        image.clipsToBounds = true
        return image
    }()
    var image2:UIImageView={
        let image = UIImageView()
        image.backgroundColor = .purple
        image.contentMode = .scaleToFill
        //image.image = UIImage(named: "View3.2")
        image.clipsToBounds = true
        return image
        
    }()
    
    var button:UIButton={
        let button = UIButton()
        return button
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addGesture()
        addTapGesture()
        print("Screen 2 VC")
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        image1.addGestureRecognizer(panGesture)
//        setColor()
    }

    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        
        mainView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view2.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
        image1.frame = CGRect(x: 0, y: 0, width: view1.frame.width, height: view1.frame.height)
     //   setView1()
        image2.frame = CGRect(x: 0, y: 0, width: view2.frame.width, height: view2.frame.height)
       // setImg2()
        
        button.frame = CGRect(x: view.frame.width/2, y: view.frame.height-100, width: 100, height: 50)
        button.backgroundColor = .white
        
        view.addSubview(mainView)
        mainView.addSubview(view1)
        mainView.addSubview(view2)
        
        
        setView1()
        setImg2()

        view1.addSubview(image1)
        view2.addSubview(image2)
        view.addSubview(button)
        checkCordinate()
    }
    
    
    
//    private func setColor(){
//        view11.backgroundColor = .red
//        view12.backgroundColor = .white
//        view21.backgroundColor = .blue
//        view22.backgroundColor = .systemPink
//    }
    
    
   private func setView1(){
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view1.bounds
       let maskPath = UIBezierPath()
       maskPath.move(to: CGPoint(x: 0, y: 0))
       maskPath.addLine(to: CGPoint(x: 0, y: view1.bounds.height))
       maskPath.addLine(to: CGPoint(x: view1.bounds.width, y: view1.bounds.height))
       maskPath.addLine(to: CGPoint(x: 0, y: 0))
        maskPath.close()
        maskLayer.path = maskPath.cgPath

        // Set the mask layer as the image view's layer mask
        view1.layer.mask = maskLayer
       image1.layer.mask = maskLayer
       
       print("maskLayer\(maskLayer)")

    }
    
    private func checkCordinate(){
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: view.frame.width, y: view.frame.height)

        let points = calculatePointsAlongLine(from: startPoint, to: endPoint)

        // Print the coordinates
        for point in points {
            print("x: \(point.x), y: \(point.y)")
        }
    }
    
    private func setImg2(){
         
         let maskLayer = CAShapeLayer()
         maskLayer.frame = view2.bounds
         let maskPath = UIBezierPath()
         maskPath.move(to: CGPoint(x: 0, y: 0))
         maskPath.addLine(to: CGPoint(x: view2.bounds.width, y: 0))
        maskPath.addLine(to: CGPoint(x: view2.bounds.width, y: view2.bounds.height))
        maskPath.addLine(to: CGPoint(x: 0, y: 0))
         maskPath.close()
         maskLayer.path = maskPath.cgPath

         // Set the mask layer as the image view's layer mask
         view2.layer.mask = maskLayer
        image2.layer.mask = maskLayer

         
     }
    
    private func addGesture(){
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(didPinch2(_:)))
        view1.addGestureRecognizer(pinchGesture1)
    }
    
    private func addTapGesture(){
        let tapGesture11 = UITapGestureRecognizer(target: self, action: #selector(handleTap1(_:)))

    }

    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        // Handle the tap event here
        view2.isUserInteractionEnabled = false
        view1.isUserInteractionEnabled = true
        view1.bringSubviewToFront(view1)
        print("View1")
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
        // Handle the tap event here
        view1.isUserInteractionEnabled = false
        view2.isUserInteractionEnabled = true
        print("View2")
    }
    
    @objc private func didPinch1(_ gesture:UIPinchGestureRecognizer){
        if gesture.state ==  .changed{
            let scale = gesture.scale
            image2.frame = CGRect(x: 0, y: 0, width: view2.frame.width*scale, height: view2.frame.height*scale)
            print(scale)
        }
    }
    
    @objc private func didPinch2(_ gesture:UIPinchGestureRecognizer){
        if gesture.state ==  .changed{
            let scale = gesture.scale
            image1.frame = CGRect(x: 0, y: 0, width: view1.frame.width*scale, height: view1.frame.height*scale)
            print(scale)
        }
    }

    
    @objc private func buttonTapped(){
        print("button tapped")
        //let DoubleVc = DiagonalViewController()
//        navigationController?.pushViewController(DoubleVc, animated: false)
    
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        // Get the translation and velocity of the gesture
        let translation = sender.translation(in: self.view)
        let velocity = sender.velocity(in: self.view)
        
        // Move the view
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        // Reset the translation so that it doesn't accumulate
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        // Log the velocity
        print("Velocity: \(velocity)")
    }
    
    func calculatePointsAlongLine(from startPoint: CGPoint, to endPoint: CGPoint) -> [CGPoint] {
        let minX = Int(min(startPoint.x, endPoint.x))
        let maxX = Int(max(startPoint.x, endPoint.x))
        let minY = Int(min(startPoint.y, endPoint.y))
        let maxY = Int(max(startPoint.y, endPoint.y))
        
        let deltaX = maxX - minX
        let deltaY = maxY - minY
        
        let isSteep = abs(deltaY) > abs(deltaX)
        
        var points: [CGPoint] = []
        
        if isSteep {
            for y in minY...maxY {
                let t = CGFloat(y - minY) / CGFloat(deltaY)
                let x = startPoint.x + t * CGFloat(deltaX)
                points.append(CGPoint(x: x, y: CGFloat(y)))
            }
        } else {
            for x in minX...maxX {
                let t = CGFloat(x - minX) / CGFloat(deltaX)
                let y = startPoint.y + t * CGFloat(deltaY)
                points.append(CGPoint(x: CGFloat(x), y: y))
            }
        }
        
        return points
    }

    
    
}

