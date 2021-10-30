//
//  DriverAnnotation.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/21.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
   dynamic var coordinate: CLLocationCoordinate2D
    var uid: String

    init(uid: String, cordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = cordinate
    }
    
    func updateAnnotationPosition(withCordinate coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 0.2) {
            self.coordinate = coordinate
        }
    }
}
