//
//  ContentView.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var agentListViewModel = AgentListViewModel()

    var body: some View {
        return VStack {
            Text("Hello world")
            Button("Press me!") {
                agentListViewModel.getAgents()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
