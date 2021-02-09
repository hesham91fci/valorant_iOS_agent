//
//  AgentsListView.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/7/21.
//

import SwiftUI
import Kingfisher

struct AgentsListView: SwiftUI.View {

    @ObservedObject var agentsViewModel = AgentListViewModel()
    var isFavorite: Bool

    private let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]

    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.agentsViewModel.getAgentsData(isFavorite: isFavorite)
    }

    var body: some SwiftUI.View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(isFavorite ? agentsViewModel.favoriteAgents : agentsViewModel.agents.data, id: \.uuid) { agent in
                        NavigationLink(destination: AgentDetailsView(agentUUID: agent.uuid)) {
                            drawAgentListItemView(color: Color.characterColors[agentsViewModel.getCurrentAgentIndex(agent: agent)], agent: agent, geometry: geometry)
                        }
                    }
                }
            }
        }
    }

    private func drawAgentListItemView(color: SwiftUI.Color, agent: AgentsData, geometry: GeometryProxy) -> some SwiftUI.View {
        ZStack {
            Rectangle().fill(color)
                .cornerRadius(30, corners: [.topRight, .bottomLeft])
                .rotation3DEffect(Angle(degrees: 4), axis: (x: 0, y:1, z:0))

            ZStack(alignment: .bottom) {
                KFImage(URL(string: agent.bustPortrait ?? ""))
                    .resizable()

                HStack(alignment: .bottom) {
                    VStack {
                        Text(agent.displayName.uppercased())
                            .font(.title2)
                            .bold()
                        Text(agent.role?.displayName ?? "")
                            .font(.title3)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .minimumScaleFactor(0.7)

                    Spacer()
                }
            }
        }
        .padding(10)
        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
    }

    private var getRandomColor: SwiftUI.Color {
        Color(
            red: .random(in: 0...0.9),
            green: .random(in: 0...0.9),
            blue: .random(in: 0...0.9)
        ).opacity(0.7)
    }

}

struct AgentsListView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        AgentsListView(isFavorite: false)
    }
}
