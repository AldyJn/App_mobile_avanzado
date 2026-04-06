import Foundation

enum LanguageParadigm {
    case Procedural
    case ObjectOriented
    case Functional
    case Mix
}
protocol Documentation {
    
    func generateDocs() -> String
    func hasExamples() -> Bool
    
}

class ProgrammingLanguage {
    var name: String
    var yearCreated: Date
    var paradigm: LanguageParadigm
    
    init(name: String, yearCreated: Date, paradigm: LanguageParadigm) {
        self.name = name
        self.yearCreated = yearCreated
        self.paradigm = paradigm
    }
    
    func getDescription() -> String {
        return "Lenguaje: \(name)"
    }
}

class CompiledLanguage: ProgrammingLanguage {
    var version: String
    
    init(name: String, yearCreated: Date, paradigm: LanguageParadigm, version: String) {
        self.version = version
        super.init(name: name, yearCreated: yearCreated, paradigm: paradigm)
    }
    
    func compile() {
        print("Compilando \(name)")
    }
}

class InterpretedLanguage: ProgrammingLanguage {
   
}

class Swift: CompiledLanguage, Documentation {
    
    override func getDescription() -> String {
        return "Swift es un lenguaje para Apple"
    }
    
    func generateDocs() -> String {
        return "Documentación de Swift"
    }
    
    func hasExamples() -> Bool {
        return true
    }
}

class Java: CompiledLanguage {

}

class Python: InterpretedLanguage {

}

class JavaScript: InterpretedLanguage {

}

let swift = Swift(name: "Swift", yearCreated: Date(), paradigm: .ObjectOriented, version: "5.5")
let python = Python(name: "Python", yearCreated: Date(), paradigm: .ObjectOriented)
