//
//  ImageAssetParser.swift
//  Regen
//
//  Created by Ido Mizrachi on 7/8/16.
//

import Cocoa

extension Images {
    class ImagesetParser {
        private static func removeAssetsPath(_ imageset: String) -> String? {
            guard let assetsPathRange = imageset.range(of: AssetsFinder.assetsSuffix) else {
                return nil
            }
            return String(imageset[imageset.index(assetsPathRange.upperBound, offsetBy: 1)...])
        }

        private static func removeImagesetSuffix(_ imageset: String) -> String? {
            if imageset.hasSuffix(Images.imagesetSuffix) {
                var mutableImageSet = imageset
                mutableImageSet.removeLast(Images.imagesetSuffix.count)
                return mutableImageSet
            } else {
                return nil
            }
        }

        func parse(_ imageset: String) -> Image? {
            guard let relativeImagename = ImagesetParser.removeAssetsPath(imageset) else {
                return nil
            }
            guard let relativeImagenameWithoutSuffix = ImagesetParser.removeImagesetSuffix(relativeImagename) else {
                return nil
            }
            var parts = relativeImagenameWithoutSuffix.split(separator: "/")
            guard parts.last != nil else {
                return nil
            }
            var image = Image()
            let filename = String(parts.last!)
            image.file = Property(name: filename, propertyName: filename.propertyName())
            parts.removeLast()
            for part in parts {
                let folder = String(part)
                image.folders.append(Property(name: folder, propertyName: folder.propertyName()))
            }


            /*
            var rangeOfFolder = imagename.range(of: "/")
            while rangeOfFolder != nil {
                let folder = imagename[..<rangeOfFolder!.lowerBound]
                metadata.folders.append(String(folder).propertyName())
                let rangeFromStart: Range<String.Index> = Range<String.Index>(uncheckedBounds: (imagename.startIndex, rangeOfFolder!.upperBound))
                imagename.removeSubrange(rangeFromStart)
                rangeOfFolder = imagename.range(of: "/")
            }*/
    //        imagename.removeLast(ImageFinder.imageSuffix.count)
    //        metadata.image = imagename
    //        metadata.property = imagename.propertyName()



    //        guard var imageName = imageAsset.components(separatedBy: "/").last else {
    //            return metadata
    //        }

            /*
            var mutableAsset = assets
            if !assets.hasSuffix("/")  {
                mutableAsset = assets + "/"
            }

            var imageName = imageAsset
            let range = imageName.range(of: mutableAsset)
            if let range = range {
                imageName.removeSubrange(range)
            }

            */


    //        if imageName.contains("/") {
                /*
                metadata.path = String(imageName[..<imageName.index(of: "/")])


                imageName = String(imageName[imageName.index(of: "/")...imageName.endIndex])
     */
    //        }

    //        let index = imageName.characters.index(imageName.endIndex, offsetBy: -ImageFinder.imageSuffix.characters.count)
    //        imageName = String(imageName[..<index])
    //        imageName = imageName.substring(to: imageName.characters.index(imageName.endIndex, offsetBy: -))
    //        metadata.imageNamed = imageName
    //        metadata.property = imageName.propertyName()
            return image
        }



    }
}
