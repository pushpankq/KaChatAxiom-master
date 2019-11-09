//
//  incomingCellTableViewCell.swift
//  ChatBubbleAdvanced
//
//  Created by Kashif Rizwan on 8/7/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import UIKit

class messageBubbleIncomingCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bubbleLayerView: UIView!
    
    var messageLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        self.bubbleLayerView.layer.insertSublayer(messageLayer, below: self.message.layer)
        self.stackView.arrangedSubviews.last?.isHidden = true
        self.stackView.arrangedSubviews.first?.isHidden = true
        messageLayer.fillColor = self.message.backgroundColor?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   usingSpringWithDamping: 1,
                                   initialSpringVelocity: 1,
                                   options: .showHideTransitionViews,
                                   animations: { () -> Void in
                                    self.stackView.arrangedSubviews.last?.isHidden = !selected
                                    self.stackView.arrangedSubviews.first?.isHidden = !selected
        },
                                   completion: nil)
    }
    
    func showIncomingMessage(text: String, cellWidth: CGFloat){
        
        let constraintRect = CGSize(width: 0.66 * cellWidth,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: self.message.font!],
                                            context: nil)
        self.message.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleSize = CGSize(width: self.message.frame.width + 28,
                                height: self.message.frame.height + 18)
        
        let width = bubbleSize.width
        let height = bubbleSize.height
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: width - 22, y: height))
        bezierPath.addLine(to: CGPoint(x: 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
        bezierPath.addLine(to: CGPoint(x: 0, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
        bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
        bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
        bezierPath.close()
        
        messageLayer.path = bezierPath.cgPath
        
        self.bubbleLayerView.frame = CGRect(x: 0.0, y: 0.0, width: cellWidth, height: height + 5)
        
        messageLayer.frame = CGRect(x: self.bubbleLayerView.frame.width - width - 20,
                                            y: self.bubbleLayerView.frame.height/2 - height/2 + 2,
                                            width: width,
                                            height: height)
    }
}
