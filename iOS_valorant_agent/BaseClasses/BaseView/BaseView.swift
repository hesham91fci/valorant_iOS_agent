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
    @ObservedObject var viewModel: BaseViewModel
    let content: Content

    init(viewModel: BaseViewModel, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.viewModel = viewModel
        self.getErrorMessage()
    }

    var body: some View {
        VStack {
            Button("test") {
                errorMessage = "test"
            }

            Button("test empty") {
                errorMessage = ""
            }

            content
                .alert(isPresented: .constant(!errorMessage.isEmpty)) {
                    Alert(title: Text("App Error"), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
                }
        }
    }

    func getErrorMessage() {
        viewModel.apiExceptionPublisher.sink {(appError) in
            errorMessage = appError.message ?? ""
            print("error Message \(appError.message ?? "")")
        }.store(in: &viewModel.subscriptions)
    }

    func displayErrorAlert() -> AnyView {
        return errorMessage.isEmpty ? AnyView(EmptyView()) : AnyView(Text(errorMessage))
    }
}
