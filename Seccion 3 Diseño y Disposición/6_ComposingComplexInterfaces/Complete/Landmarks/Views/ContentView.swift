/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of all of the landmarks.
*/

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    // Tab enum definition
    enum Tab {
        case featured
        case list
    }

    var body: some View {
        
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)

            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
        
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
