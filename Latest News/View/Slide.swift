//
//  Slide.swift
//  Latest News
//
//  Created by Farid Qanbarov on 4/5/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit


class Slide: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(quoteLabel)
        addSubview(quoteImage)
        addSubview(quoteTextView)
        setupLayout()
//        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(quoteLabel)
//        bringSubview(toFront: quoteLabel)
//        self.setupLayout()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("no")
//    }
//
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var quoteImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
     var quoteLabel : UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        return label
    }()
    
    var quoteTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.backgroundColor = .clear
        textView.adjustsFontForContentSizeCategory = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    func setupLayout() {
        let topContainer = UIView()
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            quoteImage.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            quoteImage.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            quoteImage.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.5),
            quoteImage.widthAnchor.constraint(equalTo: topContainer.widthAnchor),
//            quoteImage.heightAnchor.constraint(equalToConstant: 200),
//            quoteImage.widthAnchor.constraint(equalToConstant: 200),
            
            quoteLabel.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 25),
            quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            quoteTextView.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 10),
            quoteTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            quoteTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
//        print("-------")
//        print(quoteLabel)
    }
    
    

}
