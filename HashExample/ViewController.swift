//
//  ViewController.swift
//  HashExample
//
//  Created by David on 12.02.23.
//

import UIKit

class ViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link = ""
        
        let utm = Utm(link: link)
        print("Download link: \(getDownloadLink())")
        print("Source: \(utm.tags["source"] ?? "")")
        print("Medium: \(utm.tags["medium"] ?? "")")
        print("Campaign: \(utm.tags["campaign"] ?? "")")
        print("Content: \(utm.tags["content"] ?? "")")
        print("Term: \(utm.tags["term"] ?? "")")
    }
    
    func getDownloadLink() -> String {
        return Bundle.main.bundleURL.absoluteString
    }
}

class Utm {
    
    var tags: [String: String] = [:]
    
    init(link: String) {
        parseUTMLink(link: link)
    }
    
    func parseUTMLink(link: String) {
        let components = link.components(separatedBy: "?")
        
        if components.count > 1 {
            let parameters = components[1].components(separatedBy: "&")
            for parameter in parameters {
                let keyValue = parameter.components(separatedBy: "=")
                if keyValue.count == 2 {
                    switch keyValue[0] {
                    case "utm_source":
                        tags["source"] = keyValue[1]
                    case "utm_medium":
                        tags["medium"] = keyValue[1]
                    case "utm_campaign":
                        tags["campaign"] = keyValue[1]
                    case "utm_content":
                        tags["content"] = keyValue[1]
                    case "utm_term":
                        tags["term"] = keyValue[1]
                    default:
                        break
                    }
                }
            }
        }
    }
}

