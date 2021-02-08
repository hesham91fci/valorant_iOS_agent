//
//  ContentView.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var agentListViewModel = AgentListViewModel()
    @State var shouldShowAgentDetails: Bool = false
    @State var agentDetailsView: AgentDetailsView!
    var body: some View {
        return GeometryReader { _ in
            VStack(alignment: .leading) {
                Text("Hello world")
                    Button("Press me!") {
                        agentListViewModel.getAgents()
                    }
                    if agentListViewModel.agents != nil {
                        NavigationView {
                            NavigationLink(destination: agentDetailsView, isActive: $shouldShowAgentDetails) {
                                    Button(action: {
                                        print("login tapped")
                                        self.agentDetailsView = AgentDetailsView(agentUUID: "5f8d3a7f-467b-97f3-062c-13acf203c006")
                                        self.shouldShowAgentDetails = true
                                    }) {
                                        HStack {
                                            Spacer()
                                            Text("Login").foregroundColor(Color.white).bold()
                                            Spacer()
                                        }
                                    }
                                    .accentColor(Color.black)
                                    .padding()
                                    .background(Color(UIColor.darkGray))
                                    .cornerRadius(4.0)
                                    .padding(Edge.Set.vertical, 20)
                                }
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
