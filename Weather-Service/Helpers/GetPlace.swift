//
//  GetPlace.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/4.
//

import Foundation
import CoreLocation


public func getPlace(location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
    let locationCoordinate2D = location//CLLocation(latitude: self.latitude, longitude: self.longitude)
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(locationCoordinate2D) { placemarks, error in
        
        guard error == nil else {
            print("*** Error in \(#function): \(error!.localizedDescription)")
            completion(nil)
            return
        }
        
        guard let placemark = placemarks?[0] else {
            print("*** Error in \(#function): placemark is nil")
            completion(nil)
            return
        }
        completion(placemark)
    }
}
