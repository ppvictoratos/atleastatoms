import UIKit
import Foundation

let json =
    """
    {
      "start" : "00:00:00Z",
      "duration" : "PT0H0M604800S",
      "epgLockTime" : "PT0H0M86400S",
      "padding" : "PT0H0M0S",
      "channel" : 9999380,
      "category_names" : [
        "hungry_ciaoitalia_onnow",
        "hungry_greatchefsamerica_onnow",
        "hungry_juliajacques_onnow",
        "hungry_pati_onnow",
        "hungry_vegancorner_onnow",
        "hungry_tastehistory_onnow"
      ]
    }
""".data(using: .utf8)!

struct Model: Codable {
    let start: String?
    let duration: String?
    let epgLockTime: String?
    let padding: String?
    let channel: Int?
    let category_names: [String]?
}

let myModel = try JSONDecoder().decode(Model.self, from: json)

print(myModel)
print(myModel.start?.description)
print("\n")

extension Model {
    func description() {
        print("start: ", self.start!.description, "\n",
              "duration: ", self.duration!.description)
    }
}

myModel.description()

dump(myModel)

//codable!

//turn jsons into an array of jsons 
