//
//  HomeScreenView.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/7/21.
//

import SwiftUI

enum SegmentedPickerValues: String {
    case popular = "Popular"
    case favorites = "Favorites"
}

struct HomeScreenView: View {
    @State private var selectedValue = SegmentedPickerValues.popular.rawValue

    init() { }

    var body: some View {
        NavigationView {
            VStack {
                upperHeader

                SegmentedPicker(selectedValue: $selectedValue, pickerValues: [SegmentedPickerValues.popular.rawValue, SegmentedPickerValues.favorites.rawValue])

                listItmesView
            }
        }.navigationViewStyle(StackNavigationViewStyle())
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

    private var listItmesView: AnyView {
        if selectedValue == SegmentedPickerValues.popular.rawValue {
            return AnyView(AgentsListView())
        }
        return AnyView(EmptyView())
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
