//
//  HomeView.swift
//  MaxWin
//
//  Created by zwb on 2021/10/16.
//

import SwiftUI
struct HomeView: View {
    @ObservedObject var viewModel = MianViewModel()
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                TabView(selection: $homeVM.currHomeNavTab){
                    Color.red.tag(HomeNavTab.monitor)
                    
                    ContentView()
                        .tag(HomeNavTab.carfenxi)
                    
                    Color.blue.tag(HomeNavTab.videoplay)
                }
                .frame(width: UIScreen.main.bounds.width)
                .frame(maxHeight: .infinity,alignment: .top)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                if #available(iOS 15.0, *) {
                    HomeNavView()
                        .padding(.top, 50.0)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .environmentObject(homeVM)
                } else {
                    HomeNavView()
                        .padding(.top, 50.0)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5))
                        .environmentObject(homeVM)
                }
                
            }
            .onAppear {
                viewModel.atFront = true
            }
            .ignoresSafeArea(.all, edges: .all)
            .navigationBarTitle("") //this must be empty
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarHidden(true)
        .environmentObject(viewModel)
        
        
    }
}

