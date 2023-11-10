//
//  ContentView.swift
//  DevLife
//
//  Created by Horacio Mota on 10/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CharacterViewModel

    var body: some View {
        VStack {
            if let character = viewModel.character {
                Text("Personagem Criado:")
                Text("Nome: \(character.name)")
                Text("Idade: \(character.age)")
            } else {
                CharacterCreationView(viewModel: viewModel)
            }
        }
    }
}
