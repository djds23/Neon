//
//  ParsedText.swift
//  Neon
//
//  Created by Dean Silfen on 6/8/19.
//  Copyright © 2019 Dean Silfen. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

public final class ParsedText: BindableObject {
    public typealias PublisherType = PassthroughSubject<ParsedText, Never>

    let publisher = PublisherType()
    public var didChange: ParsedText.PublisherType {
        return publisher
    }
    
    public let sections: [ClassifiedTextSection]
    public let originalText: String

    private let dataDetector: NSDataDetector
    
    public init(text: String) {
        originalText = text
        let types: NSTextCheckingResult.CheckingType = [
            NSTextCheckingResult.CheckingType.link
        ]
        dataDetector = try! NSDataDetector(types: types.rawValue)
        sections = dataDetector
            .matches(in: text, options: [], range: text.fullRange)
            .reduce(into: [[NSTextCheckingResult]](), { memo, result in
                if let index = memo.firstIndex(where: { results -> Bool in
                    results.first?.resultType == result.resultType
                    }) {
                    memo[index].append(result)
                }
                else {
                    memo.append([result])
                }
            })
            .enumerated()
            .map { offset, results in
                ClassifiedTextSection(
                    label: results.first!.label,
                    texts: results.enumerated().map { ClassifiedText(result: $1, id: $0) },
                    id: offset
                )
            }

        publisher.send(self)
        
    }
}

public struct ClassifiedTextSection: Identifiable {
    public let label: String
    public let texts: [ClassifiedText]
    public let id: Int
}

public struct ClassifiedText: Identifiable {
    public let value: String
    public let id: Int
}

extension ClassifiedText {
    init(result: NSTextCheckingResult, id: Int) {
        self.value = result.valueText
        self.id = id
        
    }
}

extension String {
    var fullRange: NSRange {
        NSRange(location: 0, length: count)
    }
}

extension NSTextCheckingResult {
    var label: String {
        switch self.resultType {
        case .link:
            return "Link"
        default:
            return "Unknown"
        }
    }
    
    var valueText: String {
        let defaultValue = "N/A"
        switch self.resultType {
        case .link:
            return self.url?.absoluteString ?? defaultValue
        default:
            return defaultValue
        }
    }
}

