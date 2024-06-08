//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Lucas Gabriel Tais on 2024-05-24.
//

import SwiftUI

struct ContentView: View {

    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    let viewDBContext = PersistenceController.shared.container.viewContext
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                        .onAppear(perform: {
                            saveLocation(weather: weather)
                        })
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
    
    func saveLocation(weather: ResponseBody) {
        // Salva no banco
        let newLocation = Location(context: viewDBContext)
        newLocation.timestamp = Date()
        newLocation.name = weather.name
        newLocation.latitude = weather.coord.lat
        newLocation.longitude = weather.coord.lon
        try? viewDBContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
