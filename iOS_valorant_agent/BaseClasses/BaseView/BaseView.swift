//
//  BaseView.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/10/21.
//

import SwiftUI
import Combine

struct BaseView<Content: View>: View {
    @State private var errorMessage: String = ""
    @State private var shouldShouldAlert: Bool = false
    @ObservedObject var viewModel: BaseViewModel
    let content: Content

    init(viewModel: BaseViewModel, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            content
                .alert(isPresented: $shouldShouldAlert) {
                    Alert(title: Text("App Error"), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
                }.onReceive(viewModel.apiExceptionPublisher, perform: { appError in
                    errorMessage = appError.localizedDescription
                    shouldShouldAlert = true
                })
        }
    }

    func displayErrorAlert() -> AnyView {
        return errorMessage.isEmpty ? AnyView(EmptyView()) : AnyView(Text(errorMessage))
    }
}
