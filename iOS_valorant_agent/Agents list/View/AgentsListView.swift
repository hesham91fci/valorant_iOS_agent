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

    private let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]

    var body: some SwiftUI.View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(agentsViewModel.agents.data, id: \.uuid) { agent in
                        drawAgentListItemView(color: getRandomColor, agent: agent, geometry: geometry)
                    }
                }
            }
        }
    }

    private func drawAgentListItemView(color: SwiftUI.Color, agent: AgentsData, geometry: GeometryProxy) -> some SwiftUI.View {
        ZStack {
            Rectangle()
                .fill(color)
                .cornerRadius(50, corners: [.topRight, .bottomLeft])
                .rotation3DEffect(Angle(degrees: 8), axis: (x: 0, y:1, z:0))

            ZStack(alignment: .bottom) {
                    KFImage(URL(string: agent.bustPortrait ?? ""))
                        .resizable()
                        .padding([.leading], 30)

                HStack(alignment: .bottom) {
                    VStack {
                        Text(agent.displayName)
                        Text(agent.role?.displayName ?? "")
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .font(.title2)
                    .minimumScaleFactor(0.7)

                    Spacer()
                }
            }
        }
        .padding()
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
        AgentsListView()
    }
}
