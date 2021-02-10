//
//  AgentDetailsView.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/7/21.
//

import SwiftUI
import struct Kingfisher.KFImage
struct AgentDetailsView: View {

    @ObservedObject var agentDetailsViewModel: AgentDetailsViewModel = AgentDetailsViewModel(agentUUID: "")
    let agentUUID: String!
    let backgroundColor: Color

    init(agentUUID: String, backgroundColor: Color) {
        self.backgroundColor = backgroundColor
        self.agentUUID = agentUUID
        agentDetailsViewModel = AgentDetailsViewModel(agentUUID: agentUUID)
        self.agentDetailsViewModel.getAgentById()

    }

    var body: some View {
//        self.agentDetailsViewModel.agentErrorSubject.sink { (error) in
//            <#code#>
//        }
        return GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 8, content: {

                    drawUpperHeader(geometry: geometry)
                    Text("Biography")
                        .padding(.leading, 8.0)
                    Text(agentDetailsViewModel.agent?.datumDescription ?? "")
                        .padding(.leading, 8.0)
                        .padding(.bottom, 32.0)
                    Text("Special Abilities")
                        .padding(.leading, 8.0)
                    ForEach(agentDetailsViewModel.agent?.abilities ?? [], id: \.displayName) { (ability) in
                        HStack(alignment: .top, spacing: 8.0, content: {
                            abilityImage(imagePath: ability.displayIcon ?? "")
                            Text(ability.abilityDescription ?? "")
                        })
                    }

                })
            }
        }
        .navigationBarTitle("\(agentDetailsViewModel.agent?.displayName ?? "") Details")
    }

    private func drawUpperHeader(geometry: GeometryProxy) -> some View {
        ZStack {
            backgroundColor
                .cornerRadius(10)
                .padding(10)

            agentImage(imagePath: agentDetailsViewModel.agent?.fullPortrait ?? "")
                .scaleEffect(x: 3, y: 3)
                .clipped()
                .opacity(0.2)
                .frame(width: 300, height: 300 )

            HStack {

                VStack {

                    Spacer()
                    characterNameAndRole

                    ZStack(alignment: .center) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 50, height: 50)

                        favoriteButton
                    }
                    .padding([.top], 10)
                }
                agentImage(imagePath: agentDetailsViewModel.agent?.fullPortrait ?? "")
            }
            .frame(width: geometry.size.width)
        }
    }

    private var characterNameAndRole: some View {
        VStack(spacing: 3) {
            Text((agentDetailsViewModel.agent?.displayName ?? "").uppercased())
                .font(.title2)
                .bold()
            Text(agentDetailsViewModel.agent?.role?.displayName ?? "")
                .font(.title3)
        }
        .padding(.top, 100)
        .foregroundColor(Color.white)
        .minimumScaleFactor(0.7)
    }

    private var favoriteButton: some View {
        Button(action: {
            agentDetailsViewModel.toggleFavoriteAgent()
        }, label: {
            Image(systemName: agentDetailsViewModel.agent?.isFavorite ?? false ? "heart.fill" : "heart" )
                .resizable()
                .foregroundColor(agentDetailsViewModel.agent?.isFavorite ?? false ? .red : .gray)
                .frame(width: 25, height: 25)
        })

    }

    func agentImage(imagePath: String) -> some View {
        let url = URL(string: imagePath)
        return KFImage(url)
            .resizable()
            .padding(8.0)
            .frame(width: UIScreen.main.bounds.width / 1.5, height: 300)
            .aspectRatio(contentMode: .fill)
    }

    func abilityImage(imagePath: String) -> some View {
        let url = URL(string: imagePath)
        return KFImage(url)
            .resizable()
            .padding(8.0)
            .frame(width: 70, height: 70)
            .aspectRatio(contentMode: .fit)
    }
}

struct AgentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AgentDetailsView(agentUUID: "123", backgroundColor: .gray)
    }
}
