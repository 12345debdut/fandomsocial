//
//  LazyAssetImage.swift
//  fandomsocial
//
//  Created by Debdut Saha on 09/01/26.
//

import Foundation
import SwiftUI
import os

struct LazyAssetImage: View {
    let name: String
    let size: CGSize
    let scale: CGFloat
    

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.2)
            }
        }
        .frame(width: size.width, height: size.height)
        .clipped()
        .task {
            func loadDownsampledAsset(
                name: String,
                size: CGSize
            ) async -> CGImage? {
                await Task.detached(priority: .utility){
                    //try? await Task.sleep(nanoseconds: 3500_000_000)
                    guard let url = Bundle.main.url(
                        forResource: name,
                        withExtension: "jpg"
                    ),
                    let data = try? Data(contentsOf: url)
                    else { return nil }
                    return await downsample(data: data, to: size)
                }.value
            }
            if image == nil {
                let downLoadedImage = await loadDownsampledAsset(name: name, size: size)
                await MainActor.run {
                    let downloadedUIImage = downLoadedImage.map { UIImage(cgImage: $0) }
                    if let downloadedUIImage {
                        image = downloadedUIImage
                    }
                }
            }
        }
    }
    
    func downsample(
        data: Data,
        to pointSize: CGSize
    ) async -> CGImage? {
        await Task.detached(priority: .utility) {
            let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let source = CGImageSourceCreateWithData(data as CFData, sourceOptions) else { return nil }

            let maxDimension = max(pointSize.width, pointSize.height) * scale
            let options = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimension
            ] as CFDictionary
            return CGImageSourceCreateThumbnailAtIndex(source, 0, options)
        }.value
    }
}
