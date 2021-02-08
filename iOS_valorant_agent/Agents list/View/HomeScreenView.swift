//
//  HomeScreenView.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/7/21.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack {
            upperHeader

            agentsTabView
        }
    }

    var upperHeader: some View {
        VStack {
            Image("ValorantLogo")
                .resizable()
                .frame(width: 100, height: 100)
            Group {
                Text("Choose Your")
                    .bold()
                Text("awesome agents")
                    .bold()
            }
            .font(.title)
            .foregroundColor(.white)
        }
    }

    var agentsTabView: some View {
        //TabView {
            AgentsListView()
        //}
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
