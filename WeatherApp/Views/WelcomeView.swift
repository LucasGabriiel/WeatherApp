//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Lucas Gabriel Tais on 2024-05-24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the Weather App")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            
            VStack {
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
            .foregroundColor(.white)
            
            Button(action: historyButtonTapped, label: {
                HStack{
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("Location History")
                        .font(.headline)
                }
            }).buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .sheet(isPresented: $showingSheet) {
                    LocationListView() .environment(\.managedObjectContext, viewContext)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func historyButtonTapped()  {
        showingSheet.toggle()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
