/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 A view showing the list of landmarks.
 */

import SwiftUI

struct ContentView: View {
    
    @Environment(ModelData.self) var modelData
     
    var body: some View {
         LandmarkList()
    }
    
}

#Preview {
    ContentView()
        .environment(ModelData())
}
