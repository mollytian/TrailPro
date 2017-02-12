//
//  TrailMapOverlay.swift
//  TrailPro
//
//  Created by Molly Tian on 2/12/17.
//  Copyright © 2017 Molly Tian. All rights reserved.
//

import UIKit
import MapKit

class TrailMapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(trail: Trail) {
        coordinate = trail.midCoordinate
        boundingMapRect = trail.overlayBoundingMapRect
    }
}
