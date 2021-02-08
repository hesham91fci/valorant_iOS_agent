//
//  SegmentedPicker.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/8/21.
//

import SwiftUI

struct SegmentedPicker: View {
    @Binding var selectedValue: String
    var pickerValues: [String]

    init(selectedValue: Binding<String>, pickerValues: [String]) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.red.opacity(0.5))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)], for: .normal)

        self._selectedValue = selectedValue
        self.pickerValues = pickerValues
    }
    var body: some View {
        Picker("Filter", selection: $selectedValue) {
            ForEach(pickerValues, id: \.self) { test in
                Text(test).tag(test)
            }
        }
        .padding()
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: UIScreen.main.bounds.width - 50)
        .scaledToFill()
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker(selectedValue: .constant(SegmentedPickerValues.popular.rawValue), pickerValues: [SegmentedPickerValues.popular.rawValue, SegmentedPickerValues.favorites.rawValue])
    }
}
