//
//  CharacterViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 10/11/23.
//

import Foundation
import FirebaseFirestore

class CharacterViewModel: ObservableObject {
    @Published var character: Character?
    private var db = Firestore.firestore()

    // Adicione uma chave para armazenar o ID do personagem no UserDefaults
    private let characterIdKey = "CharacterId"

    func createCharacter(name: String, age: Int, completion: @escaping () -> Void) {
        // Gere um ID único para o personagem (por exemplo, um UUID)
        let characterId = UUID().uuidString

        let characterData: [String: Any] = [
            "name": name,
            "age": age
        ]

        // Crie um documento com o ID exclusivo do personagem na coleção "characters"
        db.collection("characters").document(characterId).setData(characterData) { error in
            if let error = error {
                print("Erro ao criar o personagem: \(error.localizedDescription)")
            } else {
                // Salve o ID do personagem no UserDefaults
                UserDefaults.standard.setValue(characterId, forKey: self.characterIdKey)

                self.character = Character(id: characterId, name: name, age: age)
                completion()
            }
        }
    }

    func checkCharacterStatus(completion: @escaping () -> Void) {
        // Recupere o ID do personagem do UserDefaults
        if let characterId = UserDefaults.standard.string(forKey: self.characterIdKey) {
            // Consulte o documento do personagem na coleção "characters"
            db.collection("characters").document(characterId).getDocument { document, error in
                if let document = document, document.exists {
                    if let name = document["name"] as? String, let age = document["age"] as? Int {
                        self.character = Character(id: characterId, name: name, age: age)
                    }
                } else {
                    print("Personagem não encontrado.")
                }
                completion()
            }
        } else {
            print("ID do personagem não encontrado no UserDefaults.")
            completion()
        }
    }
}

