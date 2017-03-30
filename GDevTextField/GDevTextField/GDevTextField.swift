//
//  File.swift
//  MeuTreino
//
//  Created by Gabriel Gomes on 21/03/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import Foundation
import UIKit

public class GDevTextField: UITextField {
    
    //MARK: - Override Variables
    
    override public var tintColor: UIColor! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    //MARK: - IBInspectable Variables
    
    @IBInspectable open var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    @IBInspectable open var placeholderFont: UIFont? {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    @IBInspectable open var titleColor: UIColor = UIColor.blue {
        didSet {
            if let title = self.titleLabel {
                title.textColor = self.titleColor
            }
        }
    }
    
    @IBInspectable open var titleText: String? {
        didSet {
            if let title = self.titleLabel {
                title.text = self.titleText
            }
        }
    }
    
    @IBInspectable open var titleFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            if let title = self.titleLabel {
                title.font = self.titleFont
            }
        }
    }
    
    @IBInspectable open var lineColor: UIColor = UIColor.blue {
        didSet {
            if let line = self.lineView {
                line.backgroundColor = self.lineColor
            }
        }
    }
    
    @IBInspectable open var lineHeight: CGFloat = 0.5 {
        didSet {
            guard self.lineView != nil else {
                return
            }
            
            self.lineView.frame = self.lineViewRectForBounds(self.bounds)
        }
    }
    
    @IBInspectable open var rightIcon: UIImage? {
        didSet {
            guard self.rightIcon != nil else {
                return
            }
            
            let imageView = UIImageView(image: self.rightIcon)
            self.rightViewMode = .always
            self.rightView = imageView
        }
    }
    
    @IBInspectable open var leftIcon: UIImage? {
        didSet {
            guard self.leftIcon != nil else {
                return
            }
            
            let imageView = UIImageView(image: self.leftIcon)
            self.leftViewMode = .always
            self.leftView = imageView
        }
    }
    
    @IBInspectable open var titleFadeInDuration: Double = 0.2
    @IBInspectable open var titleFadeOutDuration: Double = 0.2
    
    //MARK: - Open Variables
    
    open var titleLabel: UILabel!
    open var lineView: UIView!
    
    open var isTitleVisible: Bool {
        get {
            return self.hasText
        }
    }
    
    //MARK: - Private Variables
    
    private var titleHeight: CGFloat {
        get {
            if let title = self.titleLabel, let font = title.font {
                return font.lineHeight
            }
            
            return 15.0
        }
    }
    
    //MARK: - Override Functions
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.createTitleLabel()
        self.createLineView()
        
        // Add editingChanged observer
        self.addTarget(self, action: #selector(GDevTextField.editingChanged), for: .editingChanged)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.configure()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configure()
    }
    
    //MARK: - Private Functions
    
    private func configure() {
        self.borderStyle = .none
        self.isSelected = true
    }
    
    private func createTitleLabel() {
        
        guard self.titleLabel == nil else {
            return
        }
        
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = self.titleFont
        titleLabel.alpha = 0.0
        titleLabel.text = self.titleText
        titleLabel.textColor = self.titleColor
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    private func createLineView() {
        
        guard self.lineView == nil else {
            return
        }
        
        let lineView = UIView()
        lineView.isUserInteractionEnabled = false
        lineView.backgroundColor = self.lineColor
        lineView.frame = self.lineViewRectForBounds(self.bounds)
        self.lineView = lineView
        self.lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        self.addSubview(self.lineView)
    }
    
    private func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = self.isTitleVisible ? 1.0 : 0.0
        let frame: CGRect = self.titleLabelRectForBounds(self.bounds)
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            let animationOptions: UIViewAnimationOptions = .curveEaseOut;
            let duration = self.isTitleVisible ? self.titleFadeInDuration : self.titleFadeOutDuration
            
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    private func titleLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight
        return CGRect(x: 0, y: -self.titleHeight, width: bounds.size.width, height: titleHeight)
    }
    
    private func lineViewRectForBounds(_ bounds: CGRect) -> CGRect {
        let lineHeight = self.lineHeight
        return CGRect(x: 0, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight);
    }
    
    private func updateLineView() {
        guard self.lineView != nil else {
            return
        }
        
        self.lineView.frame = self.lineViewRectForBounds(self.bounds)
    }
    
    private func updateTitleLabel(_ animated:Bool = false) {
        self.updateTitleVisibility(animated)
    }
    
    private func updatePlaceholder() {
        if let placeholder = self.placeholder, let font = self.placeholderFont ?? self.font {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: placeholderColor, NSFontAttributeName: font])
        }
    }
    
    @objc private func editingChanged() {
        self.updateTitleVisibility(true, completion: nil)
    }
}
