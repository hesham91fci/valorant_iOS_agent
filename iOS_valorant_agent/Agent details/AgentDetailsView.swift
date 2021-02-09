//
//  AgentDetailsView.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/7/21.
//

import SwiftUI
import struct Kingfisher.KFImage
struct AgentDetailsView: View {

    @ObservedObject var agentListViewModel: AgentListViewModel = AgentListViewModel()

    let agentUUID: String!
    init( agentUUID: String) {
        self.agentUUID = agentUUID
        self.agentListViewModel.getAgentById(agentUUID: agentUUID)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 8, content: {

                   // backButton

                    ZStack {
                        agentImage(imagePath: agentListViewModel.agent?.fullPortrait ?? "")
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(agentListViewModel.agent?.displayName ?? "").padding(.leading, 8.0)
                            Text(agentListViewModel.agent?.role?.displayName ?? "").padding(.leading, 8.0)
                            Button(action: {
                                agentListViewModel.toggleFavoriteAgent()

                            }) {
                                Image(systemName: agentListViewModel.agent?.isFavorite ?? false ? "heart.fill" : "heart")
                            }
                            .padding(.trailing, 8.0)
                            .frame(width: geometry.size.width, alignment: .topTrailing)

                        }.frame(width: geometry.size.width, alignment: .topLeading)

                    }
                    Text("Biography")
                        .padding(.leading, 8.0)
                    Text(agentListViewModel.agent?.datumDescription ?? "")
                        .padding(.leading, 8.0)
                        .padding(.bottom, 32.0)
                    Text("Special Abilities")
                        .padding(.leading, 8.0)
                    ForEach(agentListViewModel.agent?.abilities ?? [], id: \.displayName) { (ability) in
                        HStack(alignment: .top, spacing: 8.0, content: {
                            abilityImage(imagePath: ability.displayIcon ?? "")
                            Text(ability.abilityDescription ?? "")
                        })
                    }

                })
            }
        }
        .navigationBarTitle("\(agentListViewModel.agent?.displayName ?? "") Details")

    }

    func agentImage(imagePath: String) -> some View {
        let url = URL(string: imagePath)
        return KFImage(url)
            .resizable()
            .padding(8.0)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.3)
            .aspectRatio(contentMode: .fill)
    }

    func abilityImage(imagePath: String) -> some View {
        let url = URL(string: imagePath)
        return KFImage(url)
            .resizable()
            .padding(8.0)
            .frame(width: 70, height: 70)
            .aspectRatio(contentMode: .fill)
    }

//    var backButton: some View {
//        Button {
//            self.presentationMode.wrappedValue.dismiss()
//        } label: {
//            Image(systemName: "chevron.backward")
//                .foregroundColor(Color.white)
//        }
//    }
}

struct AgentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AgentDetailsView(agentUUID: "123")
            AgentDetailsView(agentUUID: "123")
        }

    }
}
