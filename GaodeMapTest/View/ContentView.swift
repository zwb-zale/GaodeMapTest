//
//  ContentView.swift
//  GaodeMapTest
//
//  Created by zwb on 2021/10/27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mapVM = ViewModel()
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            GaodeMapView().environmentObject(mapVM)
            HStack (spacing: 20) {
                Button(action: {
                    mapVM.change_map_type(.standard)

                }) {

                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                        Text("标准")
                            .foregroundColor(Color.white)
                    }

                }
                Button(action: {
                    mapVM.change_map_type(.standardNight)

                }) {

                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                        Text("黑夜")
                            .foregroundColor(Color.white)
                    }

                }
                Button(action: {
                    mapVM.search_route_point()

                }) {

                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                        Text("画线")
                            .foregroundColor(Color.white)
                    }

                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
        }
        .ignoresSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
