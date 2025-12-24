//
//  CustomImage.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//

import SwiftUI


enum ImageType: Identifiable, Hashable {
    case SystemImage(String)
    case CustomImage(String)
    
    var id: String {
        switch self {
        case let .SystemImage(name):
            return "systemImage_\(name)"
        case let .CustomImage(name):
            return "customImage_\(name)"
        }
    }
}

func makeImage(from type: ImageType) -> Image {
    switch type {
    case let .SystemImage(name):
        return Image(systemName: name)
    case let .CustomImage(name):
        return Image(name)
    }
}
