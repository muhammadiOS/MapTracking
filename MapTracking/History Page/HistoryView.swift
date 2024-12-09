//
//  HistoryView.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 05/12/2024.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @State private var routes: [Route] = []
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(routes) { route in
                    NavigationLink {
                        RouteView(route: route)
                    } label: {
                        Text(route.name)
                    }
                }
            }.listStyle(InsetGroupedListStyle())
        }.onAppear() {loadData()}
    }
    
    private func loadData() {
        
        let routePredicate = #Predicate<Route> {_ in true}
        
        let descriptor = FetchDescriptor<Route>(predicate: routePredicate)

        routes = (try? context.fetch(descriptor)) ?? []
    }
}

#Preview {
    HistoryView()
}
