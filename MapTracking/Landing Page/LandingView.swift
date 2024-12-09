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
            
            ZStack {
                Image("wallPapre", bundle: nil)
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .center,
                       spacing: 80) {
                    Button("Map") {
                        viewModel.isMapViewPresented = true
                    }
                    .frame(width: 200, height: 40)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $viewModel.isMapViewPresented) {
                        MapView()}
                    Button("History") {
                        viewModel.isHistoryViewPresented = true
                    }
                    .frame(width: 200, height: 40)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $viewModel.isHistoryViewPresented) {
                        HistoryView()}
                }
            }
            
            
        }
    }
}

#Preview {
    LandingView()
}
