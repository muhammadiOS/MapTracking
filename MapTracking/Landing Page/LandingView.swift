//
//  LandingView.swift
//  MapTracking
//
//  Created by Muhammad AbdelRahman on 05/12/2024.
//

import SwiftUI

struct LandingView: View {
    @ObservedObject var viewModel: LandingVM = LandingVM()
    var body: some View {
        NavigationStack {
            VStack(alignment: .center,
                   spacing: 120) {
                Button("Map") {
                    viewModel.isMapViewPresented = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .navigationDestination(isPresented: $viewModel.isMapViewPresented) {
                    MapView()}
                Button("History") {
                    viewModel.isHistoryViewPresented = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .navigationDestination(isPresented: $viewModel.isHistoryViewPresented) {
                    HistoryView()}
            }
        }
        
        
    }
}

#Preview {
    LandingView()
}
