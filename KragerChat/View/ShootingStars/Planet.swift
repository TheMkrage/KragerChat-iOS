//
//  Planet.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/8/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Planet: UIView {
    
    var imageView: UIImageView!

    init(image: UIImage) {
        super.init(frame: .zero)
        imageView = UIImageView(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}
