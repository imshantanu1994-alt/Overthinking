//
//  TherapistsMapView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import MapKit
import SwiftUI

struct TherapistsMapView: View {
    @Environment(GardenViewModel.self) var vm
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964),
        span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    )

    var body: some View {
        NavigationStack {
            VStack {
                Map(coordinateRegion: $region, annotationItems: vm.therapists) {
                    t in
                    MapAnnotation(coordinate: t.coordinate) {
                        VStack {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.white).padding(8).background(
                                    Color.blue
                                ).clipShape(Circle()).onTapGesture {
                                    vm.openInMaps(therapist: t)
                                }
                            Text(t.name).font(.caption)
                        }
                    }
                }
                .frame(height: 320)

                List(vm.therapists) { t in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(t.name)
                            Text(t.specialty).font(.caption).foregroundColor(
                                .gray
                            )
                        }
                        Spacer()
                        Button("Open in Maps") { vm.openInMaps(therapist: t) }
                    }
                }
            }
            .navigationTitle("Therapists Nearby")
        }
    }
}
