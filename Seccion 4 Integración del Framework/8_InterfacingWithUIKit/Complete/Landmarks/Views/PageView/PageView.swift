/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct PageView<Page: View>: View {
    
    var pages: [Page]
    
    @State private var currentPage = 0

    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            PageViewController(pages: pages, currentPage: $currentPage) // imagen de la pagina
            
            PageControl(numberOfPages: pages.count, currentPage: $currentPage) // control personalizado (3 puntitos)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
            
        }
        .aspectRatio(3 / 2, contentMode: .fit)
        
        Text("Current Page: \(currentPage)")
    }
}

#Preview {
    PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
}
