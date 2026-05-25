//
//  CoreDataContextProviding.swift
//  lab_11_Montoya
//

import UIKit
import CoreData

protocol CoreDataContextProviding: AnyObject {
    func conexion() -> NSManagedObjectContext
}

extension CoreDataContextProviding {
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    func guardarContexto() {
        do {
            try conexion().save()
        } catch {
            print("Error al guardar: \(error)")
        }
    }
}
