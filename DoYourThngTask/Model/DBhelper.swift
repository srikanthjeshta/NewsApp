//
//  DBhelper.swift
//  DoYourThngTask
//
//  Created by Work Station 2 on 08/09/21.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
        
        createTable1()

    }

    let dbPath: String = "svbbDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print("filefileurl",fileURL)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS campaign(todaydate TEXT, title TEXT, description TEXT, imgvw TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func createTable1() {
        let createTableString = "CREATE TABLE IF NOT EXISTS campaigndata(Id INTEGER PRIMARY KEY, name TEXT, campaignpic TEXT, brandname TEXT, brandpic TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(todayDate:String,title:String,desc:String,imgVw:String)
    {
           // let persons = read()
//            for p in persons
//            {
//                if p.id == id
//                {
//                    return
//                }
//            }
            let insertStatementString = "INSERT INTO campaign (todaydate, title, description, imgvw) VALUES (?, ?,?,?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               // sqlite3_bind_int(insertStatement, 1, Int32(Int(todayDate) ?? 0))

                sqlite3_bind_text(insertStatement, 1, (todayDate as NSString).utf8String, 1, nil)
                sqlite3_bind_text(insertStatement, 2, (title as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (desc as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (imgVw as NSString).utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
    
    
  
    
    
    func read() -> [News] {
        let queryStatementString = "SELECT * FROM campaign;"
        var queryStatement: OpaquePointer? = nil
        var psns : [News] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let todayDate = sqlite3_column_int(queryStatement, 0)
                //let todayDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                //psns.append(Campaign(id: Int(id), name: name, age: Int(year)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let imgvw = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                psns.append(News(todayDate: String(todayDate), title: String(title), desc: String(description), imgVw: String(imgvw)))
               // psns.append(Campaign(id: Int(id), name: name, campaignpic: campaignpic, brandname: brandname, brandpic: brandpic))
                print("Query Result:")
                //print("\(id) | \(name) |")
                print("\(todayDate) | \(title) | \(description) | \(imgvw) |")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
