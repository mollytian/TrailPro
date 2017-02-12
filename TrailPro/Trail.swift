//
//  Trail.swift
//  TrailPro
//
//  Created by Molly Tian on 2/10/17.
//  Copyright © 2017 Molly Tian. All rights reserved.
//

import UIKit
import MapKit

class Trail: NSObject {
    
    // MARK: - Properties
    
    var boundary: [CLLocationCoordinate2D] = []
    var boundaryPointsCount: NSInteger = 0
    
    var midCoordinate: CLLocationCoordinate2D
    var overlayTopLeftCoordinate: CLLocationCoordinate2D
    var overlayTopRightCoordinate: CLLocationCoordinate2D
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D
    
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                              overlayTopRightCoordinate.longitude)
        }
    }
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
            
            return MKMapRectMake(topLeft.x,
                                 topLeft.y,
                                 fabs(topLeft.x-topRight.x),
                                 fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    var name: String?
    
    // MARK: - initializers
    
    override init() {
        midCoordinate = CLLocationCoordinate2DMake(30.400788, -97.686192)
        overlayTopLeftCoordinate = CLLocationCoordinate2DMake(30.406404, -97.696555)
        overlayTopRightCoordinate = CLLocationCoordinate2DMake(30.406404, -97.677028)
        overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(30.394212, -97.696555)
    }
    
    
}
