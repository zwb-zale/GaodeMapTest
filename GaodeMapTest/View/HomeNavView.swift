//
//  HomeNavView.swift
//  MaxWin
//
//  Created by maxwin on 2021/10/18.
//

import SwiftUI

struct HomeNavView: View {
    @EnvironmentObject var viewModel: MianViewModel
    
    
    @State var openSearchCompanyView: Bool = false
    var body: some View {
        HStack {
            HomeNavTabBtn(tab: HomeNavTab.monitor)
            HomeNavTabBtn(tab: HomeNavTab.carfenxi)
            HomeNavTabBtn(tab: HomeNavTab.videoplay)
        }
        .padding(.horizontal,10)
    }
}
enum HomeNavTab: String {
    case monitor   = "监控"
    case carfenxi  = "地图"
    case videoplay = "回放"
}

struct HomeNavTabBtn: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var tab: HomeNavTab
    var body: some View {
        Button(action: {
            withAnimation(){
                homeVM.currHomeNavTab = tab
            }
        }) {
            Text(tab.rawValue)
                .padding(.horizontal,15)
                .font(.system(size: 16, weight: homeVM.currHomeNavTab == tab ? .bold : .medium))
                .foregroundColor(Color.black.opacity(homeVM.currHomeNavTab == tab ? 1 : 0.7))
                .scaleEffect(homeVM.currHomeNavTab == tab ? 1.3 : 1)
        }
    }
}

