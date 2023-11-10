//
//  CharacterCreationView.swift
//  DevLife
//
//  Created by Horacio Mota on 10/11/23.
//

import SwiftUI

struct CharacterCreationView: View {
    @ObservedObject var viewModel: CharacterViewModel
    @State private var name = ""
    @State private var age = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            TextField("Nome", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Idade", text: $age)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()

            Button(action: {
                if let ageInt = Int(age) {
                    viewModel.createCharacter(name: name, age: ageInt) {
                        showAlert = true
                    }
                } else {
                    showAlert = true
                }
            }) {
                Text("Criar Personagem")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Personagem Criado"), message: Text("Seu personagem foi criado com sucesso!"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

