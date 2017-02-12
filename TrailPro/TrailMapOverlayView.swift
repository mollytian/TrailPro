//
//  TrailMapOverlayView.swift
//  TrailPro
//
//  Created by Molly Tian on 2/12/17.
//  Copyright © 2017 Molly Tian. All rights reserved.
//

import UIKit
import MapKit

class TrailMapOverlayView: MKOverlayRenderer {
    
    var overlayImage: UIImage
    
    init(overlay:MKOverlay, overlayImage:UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    

    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let imageReference = overlayImage.cgImage
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rect(for: theMapRect)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -theRect.size.height)
        context.draw(imageReference!, in: theRect)
    }
}
