//
//  RegistrationFormExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 19/02/22.
//

import Combine
import SwiftUI

struct RegistrationFormExample: View {
    @ObservedObject private var viewModel = UserRegistrationViewModel()

    var body: some View {
        VStack {
            Text("Create an account")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(.bottom, 30)

            FormField(fieldName: "Username", fieldValue: $viewModel.username)
            RequirementText(text: "A minimum of 4 characters",
                            isStrikeThrough: viewModel.isUsernameLengthValid)
                .padding()

            FormField(fieldName: "Password",
                      fieldValue: $viewModel.password,
                      isSecure: true)
            VStack {
                RequirementText(iconName: "lock.open",
                                text: "A minimum of 8 characters",
                                isStrikeThrough: viewModel.isPasswordLengthValid)
                RequirementText(iconName: "lock.open",
                                text: "One uppercase letter",
                                isStrikeThrough: viewModel.isPasswordCapitalLetter)
            }
            .padding()

            FormField(fieldName: "Confirm Password",
                      fieldValue: $viewModel.confirmPassword,
                      isSecure: true)
            RequirementText(text: "Your confirm password should be the same as password",
                            isStrikeThrough: viewModel.isPasswordConfirmValid)
                .padding()
                .padding(.bottom, 50)

            Button {

            } label: {
                Text("Sign Up")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            HStack {
                Text("Already have an account?")
                    .font(.system(.body, design: .rounded))
                    .bold()

                Button {

                } label: {
                    Text("Sign in")
                        .font(.system(.body, design: .rounded))
                        .bold()
                }
            }
            .padding(.top, 50)

            Spacer()
        }
        .padding()
    }
}

struct RegistrationFormExample_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormExample()
    }
}

struct FormField: View {
    var fieldName: String

    @Binding var fieldValue: String

    var isSecure: Bool = false

    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName,
                            text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            } else {
                TextField(fieldName,
                          text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }

            Divider()
                .frame(height: 1)
                .background(.gray)
                .padding(.horizontal)
        }
    }
}

struct RequirementText: View {
    private let iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)

    private let text: String
    private let isStrikeThrough: Bool

    private let iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)

            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)

            Spacer()
        }
    }

    init(text: String, isStrikeThrough: Bool) {
        self.text = text
        self.isStrikeThrough = isStrikeThrough
        self.iconName = "xmark.square"
    }

    init(iconName: String, text: String, isStrikeThrough: Bool) {
        self.text = text
        self.isStrikeThrough = isStrikeThrough
        self.iconName = iconName
    }
}

class UserRegistrationViewModel: ObservableObject {
    // Input
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    // Output
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        $username
            .receive(on: RunLoop.main)
            .map { $0.count >= 4 }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { $0.count >= 8 }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest($password, $confirmPassword)
            .receive(on: RunLoop.main)
            .map { !$1.isEmpty && $0 == $1 }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
}
