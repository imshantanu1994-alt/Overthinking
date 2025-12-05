//
//  Therapist.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import CoreLocation
import Foundation

struct Therapist: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let specialty: String
}
