//
//  Maps.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI
import MapKit

struct Maps: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            Marker("my location", systemImage: "paperplane" ,coordinate: .userLocation)
                .tint(.cyan)
      
        ForEach(results, id: \.self) { item in
            
            if routeDisplaying {
                if item == routeDestination {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            } else {
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }

            }
            
            if let route {
                MapPolyline(route.polyline).stroke(CustomColors.cyan, lineWidth: 6)
            }
        }
        .overlay(alignment: .top) {
            TextField("Search gym", text: $searchText)
                .font(.subheadline).padding(12)
                .background(.white)
                .padding()
                .shadow(radius: 12)
        }

        .onSubmit(of: .text) {
            Task { await search() }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
           showDetails = newValue != nil
        })
        .onChange(of: getDirections, { oldValue, newValue in
            if newValue {
                fetchRoute()
            }
        })
        .sheet(isPresented: $showDetails, content: {
            LocationDetailsView(mapSelection: $mapSelection,
                                show: $showDetails,
                                getDirections: $getDirections)
                .presentationDetents([.height(400)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(400))) // make interaction with the map enabled even if the sheet is presented
                .presentationCornerRadius(12)
        })
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

extension Maps {
    func search() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
    
    func fetchRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
        request.destination = mapSelection
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            routeDestination = mapSelection
            
            withAnimation(.snappy) {
                routeDisplaying = true
                showDetails = false
                if let rect = route?.polyline.boundingMapRect, routeDisplaying {
                    cameraPosition = .rect(rect)
                }
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        // 59.335318345496184, 18.063203910569936
        return .init(latitude: 59.335318345496184, longitude: 18.063203910569936)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
    }
}

struct MapsView_Previews: PreviewProvider {
    static var previews: some View {
        Maps()
    }
}


#Preview {
    Maps()
}
