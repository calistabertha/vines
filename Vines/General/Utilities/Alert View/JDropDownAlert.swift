//
//  JDropDownAlert.swift
//
//  Created by Trilliwon on 2016. 4. 21..
//  Copyright (c) 2016 trilliwon <trilliwon@gmail.com> All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit

public enum AlertPosition {
    case top
    case bottom
}

public enum AnimationDirection {
    case toLeft
    case toRight
    case normal
}

open class JDropDownAlert: UIButton {
    
    // default values
    // You can change this values to customize
    var height: CGFloat = 70
    var duration = 0.3
    var delay: Double = 2.0
    
    fileprivate var titleFrame: CGRect!
    fileprivate var topLabel = UILabel()
    fileprivate var messageLabel = UILabel()
    fileprivate  var imgIcon = UIImageView()
    
    open var position = AlertPosition.top
    open var direction = AnimationDirection.normal
    
    fileprivate let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    fileprivate let screenWidth = UIScreen.main.bounds.size.width
    fileprivate let screenHeight = UIScreen.main.bounds.size.height
    
    open var titleFont:UIFont = UIFont.boldSystemFont(ofSize: 14) {
        didSet{
            topLabel.font = titleFont
        }
    }
    
    open var messageFont:UIFont = UIFont.systemFont(ofSize: 12) {
        didSet{
            messageLabel.font = messageFont
        }
    }
    
    open var didTapBlock: (() -> ())?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(position: AlertPosition = .bottom, direction: AnimationDirection = .normal) {
        super.init(frame: CGRect.zero)
        
        self.frame = getFrameBy(position, direction: direction)
        self.direction = direction
        self.position = position
        setDefaults()
    }
    
    
    
    fileprivate func setDefaults() {
        setTitleDefaults()
        setMessageDefaults()
        setImageDefaults()
        self.backgroundColor = UIColor.lightRed()
        self.addTarget(self, action: #selector(viewDidTap), for: .touchUpInside)
    }
    
    fileprivate func setTitleDefaults() {
        
        if self.position == .top {
            titleFrame = CGRect(x: 45, y: 15, width: frame.size.width - 10, height: 20)
        }else {
            titleFrame = CGRect(x: 45, y: 15, width: frame.size.width - 10, height: 20)
        }
        
        topLabel = UILabel(frame: titleFrame)
        topLabel.textAlignment = .left
        topLabel.numberOfLines = 2
        topLabel.textColor = UIColor.white
        topLabel.font = self.titleFont
        addSubview(topLabel)
    }
    
    fileprivate func setMessageDefaults() {
        let messageFrame:CGRect
        
        if self.position == .top {
            messageFrame = CGRect(x: 45, y: 15 + titleFrame.height + 5, width: frame.size.width - 10, height: 20)
        }else {
            messageFrame = CGRect(x: 45, y: titleFrame.size.height + titleFrame.height, width: frame.size.width - 10, height: 20)
        }
        messageLabel = UILabel(frame: messageFrame)
        messageLabel.textAlignment = .left
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 2
        messageLabel.textColor = UIColor.white
        messageLabel.font = self.messageFont
        addSubview(messageLabel)
    }
    
    fileprivate func setImageDefaults() {
        let imgIconFrame:CGRect
        
        if self.position == .top{
            imgIconFrame = CGRect(x: 19, y: 15 + titleFrame.height  , width: 18, height: 18)
        }else{
            imgIconFrame = CGRect(x: 19, y: 15, width: 20, height: 20)
        }
        imgIcon.frame = imgIconFrame
        addSubview(imgIcon)
        
    }
    
    
    fileprivate func getFrameBy(_ position: AlertPosition, direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        
        switch position {
        case .top:
            frame = getFrameOfTopPositionBy(direction)
        case .bottom:
            frame = getFrameOfBottomPositionBy(direction)
        }
        
        return frame
    }
    
    fileprivate func getFrameOfTopPositionBy(_ direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        switch direction {
        case .toRight:
            frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: height)
        case .toLeft:
            frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: height)
        case .normal:
            frame = CGRect(x: 0.0, y: -height, width: screenWidth, height: height)
        }
        return frame
    }
    
    fileprivate func getFrameOfBottomPositionBy(_ direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        switch direction {
        case .toRight:
            frame = CGRect(x: -screenWidth, y: screenHeight - height, width: screenWidth, height: height)
        case .toLeft:
            frame = CGRect(x: screenWidth, y: screenHeight - height, width: screenWidth, height: height)
        case .normal:
            frame = CGRect(x: 0.0, y: screenHeight + height, width: screenWidth, height: height)
        }
        return frame
    }
    
    
    
    @objc fileprivate func viewDidTap() {
        didTapBlock?()
        hide(self)
    }
    
    
    
    // MARK: - Hub methods
    @objc fileprivate func show(_ title: String, message: String?, topLabelColor: UIColor, messageLabelColor: UIColor, backgroundColor: UIColor?, image: UIImage?) {
        
        addWindowSubview(self)
        configureProperties(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor, image: image)
        
        UIView.animate(withDuration: self.duration, animations: {
            
            switch self.direction {
            case .toRight:
                self.frame.origin.x = 0
            case .toLeft:
                self.frame.origin.x = 0
            case .normal:
                self.position == .top ? (self.frame.origin.y = 0) : (self.frame.origin.y = self.screenHeight-self.height)
            }
        })
        perform(#selector(hide), with: self, afterDelay: self.delay)
    }
    
    @objc fileprivate func hide(_ alertView: UIButton) {
        
        UIView.animate(withDuration: duration, animations: {
            
            switch self.direction {
            case .toRight:
                self.frame.origin.x = -self.screenWidth
            case .toLeft:
                self.frame.origin.x = self.screenWidth
            case .normal:
                (self.position == .top) ? (alertView.frame.origin.y = -self.height) : (alertView.frame.origin.y = self.screenHeight)
            }
        })
        
        perform(#selector(remove), with: alertView, afterDelay: delay)
    }
    
    
    
    @objc fileprivate func addWindowSubview(_ view: UIView) {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindowLevelNormal
                    && !window.isHidden
                    && window.frame != CGRect.zero {
                    window.addSubview(view)
                    return
                }
            }
        }
    }
    
    @objc fileprivate func remove(_ alertView: UIButton) {
        alertView.removeFromSuperview()
    }
    
    
    
    @objc fileprivate func configureProperties(_ title: String, message: String?, topLabelColor: UIColor?, messageLabelColor: UIColor?, backgroundColor: UIColor?, image: UIImage?) {
        topLabel.text = title
        
        if let message = message {
            messageLabel.text = message
        }else {
            messageLabel.isHidden = true
            topLabel.frame.origin.y = height/2
            
            if self.position == .bottom {
                topLabel.frame.origin.y = height/2 - topLabel.frame.height/2
            }
        }
        
        if let topLabelColor = topLabelColor {
            topLabel.textColor = topLabelColor
        }
        
        if let messageLabelColor = messageLabelColor {
            messageLabel.textColor = messageLabelColor
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let image = image{
            imgIcon.image = image
        }
    }
    
    // MARK: Interface
    open func alertWith(_ title: String,
                        message: String? = nil,
                        topLabelColor: UIColor = UIColor.white,
                        messageLabelColor: UIColor = UIColor.white,
                        backgroundColor: UIColor = UIColor.black, image: UIImage? = nil) {
        self.delay = 2.0
        show(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor, image: image)
    }
    
    open func alertWith(_ title: String,
                        message: String? = nil,
                        topLabelColor: UIColor = UIColor.white,
                        messageLabelColor: UIColor = UIColor.white,
                        backgroundColor: UIColor = UIColor.black,
                        delay:Double) {
        self.delay = delay
        show(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor, image: nil)
    }
}
