//
//  anotherViewController.swift
//  ScreenDemoNew
//
//  Created by Pankaj Yadav on 08/05/23.
//

import UIKit

class anotherViewController: UIViewController {

    
    var cordArr:[(Float,Float)] = []
    var mainView:UIView={
        let view = UIView()
          view.backgroundColor = .white
         view.isUserInteractionEnabled = true
         view.clipsToBounds = true
         return view
    }()
    
    var view1:UIView={
       let view = UIView()
        view.backgroundColor = .systemBlue
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    var view2:UIView={
       let view = UIView()
        view.backgroundColor = .systemPink
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    var image1:UIImageView={
        let image = UIImageView()
        image.backgroundColor = .blue
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "View3.1")
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    var image2:UIImageView={
        let image = UIImageView()
        image.backgroundColor = .purple
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "View3.2")
        image.isUserInteractionEnabled = false
        image.clipsToBounds = true
        return image
        
    }()
    

    override func viewDidLoad(){
        super.viewDidLoad()
        
        checkCordinate()
        addGesture()
        print("Screen 2 VC")
//        setColor()

        
    }

    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        
        mainView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view2.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        image1.frame = CGRect(x: 0, y: 0, width: view1.bounds.width, height: view1.bounds.height)
        image2.frame = CGRect(x: 0, y: 0, width: view2.bounds.width, height: view2.bounds.height)
        

        view.addSubview(view1)
        view.addSubview(view2)
        //view.addSubview(mainView)
        
        view1.addSubview(image1)
        view2.addSubview(image2)
        
        setView1()
        setImg2()
        
    }
    
    
    
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
     //  image1.layer.mask = maskLayer
       
       print("maskLayer\(maskLayer)")

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
     //   image2.layer.mask = maskLayer

         
     }
    
    private func addGesture(){
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        view.addGestureRecognizer(pinchGesture1)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture1)
//        let panGesture1 = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
//        image1.addGestureRecognizer(panGesture1)
//        let panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan2(sender:)))
//        image2.addGestureRecognizer(panGesture2)
    }
    

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let touchPoint = gesture.location(in: view)
            let x = Int(touchPoint.x)
            let y = Int(touchPoint.y)
        
      //  print(cordArr)
        print("tapp tried")
        
            print("Tapped at coordinates x = ",x,"y = ",Float(y))
        
        guard let xValue = searchX(forY: Float(y), in: cordArr) else{
            return
        }
        
        if xValue>Float(x){
            image2.isUserInteractionEnabled = true
            image1.isUserInteractionEnabled = false
            print("Tapped in 2 view")
        }else{
            image1.isUserInteractionEnabled = true
            image2.isUserInteractionEnabled = false
            print("Tapped in 1 view")
        }
        
        
        }
    
    
    @objc private func didPinch(_ gesture:UIPinchGestureRecognizer){
        if gesture.state ==  .changed{
            let touchPoint = gesture.location(in: view)
            let x = Int(touchPoint.x)
            let y = Int(touchPoint.y)
        
      //  print(cordArr)
        
            print("Tapped at coordinates x = ",x,"y = ",Float(y))
        
        guard let xValue = searchX(forY: Float(y), in: cordArr) else{
            return
        }
        
            let scale = gesture.scale
            
        if xValue>Float(x){
            image1.frame = CGRect(x: 0, y: 0, width: view1.frame.width*scale, height: view1.frame.height*scale)
            print("Tapped in 2 view")
        }else{
            
            image2.frame = CGRect(x: 0, y: 0, width: view1.frame.width*scale, height: view1.frame.height*scale)
            print("Tapped in 1 view")
        }
            
            
            
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
        
        // Get the tap location relative to the view
        let tapLocation = sender.location(in: self.view)
        
        // Check if the tap is inside image1 or image2
        if sender.view == image1 {
            // Tapped inside image1
            print("Tapped inside image1 at \(tapLocation)")
        } else if sender.view == image2 {
            // Tapped inside image2
            print("Tapped inside image2 at \(tapLocation)")
        }
        
        // Move the view
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        // Reset the translation so that it doesn't accumulate
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        // Log the velocity
        print("Velocity: \(velocity)")
    }
    
    @objc func handlePan2(sender: UIPanGestureRecognizer) {
        // Get the translation and velocity of the gesture
        let translation = sender.translation(in: self.view)
        let velocity = sender.velocity(in: self.view)
        
        // Get the tap location relative to the view
        let tapLocation = sender.location(in: self.view)
        
        // Check if the tap is inside image1 or image2
        if sender.view == image1 {
            // Tapped inside image1
            print("Tapped inside image1 at \(tapLocation)")
        } else if sender.view == image2 {
            // Tapped inside image2
            print("Tapped inside image2 at \(tapLocation)")
        }
        
        // Move the view
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        // Reset the translation so that it doesn't accumulate
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        // Log the velocity
        print("Velocity: \(velocity)")
    }

    private func checkCordinate(){
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: view.frame.width, y: view.frame.height)

        let points = calculatePointsAlongLine(from: startPoint, to: endPoint)
        cordArr = points.map { point in
            return (Float(point.x), Float(point.y))
        }

        //print(cordArr)
        
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

    
    func searchX(forY y: Float, in array: [(Float, Float)]) -> Float? {
        if let result = array.first(where: { $0.1 == y }) {
            return result.0
        }
        return nil
    }

    
}
