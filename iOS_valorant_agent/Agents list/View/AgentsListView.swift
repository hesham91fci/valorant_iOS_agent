//
//  AgentsListView.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/7/21.
//

import SwiftUI
import struct Kingfisher.KFImage

struct AgentsListView: View {

    @ObservedObject var agentsViewModel = AgentListViewModel()
    var isFavorite: Bool

    var agentsData: [AgentsData] {
        isFavorite ? agentsViewModel.favoriteAgents : agentsViewModel.agents.data
    }
    private let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]

    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.agentsViewModel.getAgentsData(isFavorite: isFavorite)
    }

    var body: some View {
        BaseView(viewModel: agentsViewModel) {
            GeometryReader { geometry in
                if agentsData.count == 0 {
                    if isFavorite {
                        emptyFavoritesView
                    } else {
                        progressView
                    }
                } else {
                    drawAgentsList(geometry: geometry)
                }
            }
        }
    }

    private var progressView: some View {
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    private var emptyFavoritesView: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("No Favorites")
                .font(.title)
            Spacer()
        }.padding([.top], 100)
    }

    private func drawAgentsList(geometry: GeometryProxy) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(agentsData, id: \.uuid) { agent in
                    let agentIndex = agentsViewModel.getCurrentAgentIndex(agent: agent)
                    let characterColor = Color.characterColors[agentIndex]
                    NavigationLink(destination: AgentDetailsView(agentUUID: agent.uuid, backgroundColor: characterColor)) {
                        drawListItem(color: characterColor, agent: agent, geometry: geometry)
                    }
                }
            }
        }
    }

    private func drawListItem(color: Color, agent: AgentsData, geometry: GeometryProxy) -> some View {
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
}

struct AgentsListView_Previews: PreviewProvider {
    static var previews: some View {
        AgentsListView(isFavorite: false)
    }
}
