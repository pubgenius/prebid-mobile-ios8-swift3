/*   Copyright 2018-2019 Prebid.org, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import UIKit

public class NativeRequest: AdUnit {
    
    var version:String! = "1.2"
    public var context:ContextId?
    public var contextSubType: ContextSubTypeId?
    public var placementType:PlacementId?
    public var placementCount:Int? = 1
    public var sequence:Int?  = 0
    public var assets: Array<NativeAsset>!
    public var asseturlsupport:Int? = 0
    public var durlsupport:Int? = 0
    public var eventtrackers:Array<NativeEventTracker>?
    public var privacy:Int? = 0
    public var ext:AnyObject?
    
    public required init(configId: String) {
        super.init(configId: configId, size:nil)
    }
    
    public convenience init(configId: String, assets:Array<NativeAsset>) {
        self.init(configId: configId)
        self.assets = assets
    }
    
    func getNativeRequestObject() -> [AnyHashable: Any]? {
        var nativeObject: [AnyHashable:Any] = [:]
        nativeObject["ver"] = version
        if(assets != nil){
            var assetsObjects:[Any] = []
            for asset:NativeAsset in assets {
                assetsObjects.append(asset.getAssetObject())
            }
            
            nativeObject["assets"] = assetsObjects
        }
        if(eventtrackers != nil && eventtrackers!.count > 0){
            var eventObjects:[Any] = []
            for event:NativeEventTracker in eventtrackers! {
                eventObjects.append(event.getEventTracker())
            }
            
            nativeObject["eventtrackers"] = eventObjects
        }
        
        return nativeObject
    }

}

@objc public enum ContextId: Int {
    case Content = 1
    case Social = 2
    case Product = 3
    case TBD = 500
}

@objc public enum ContextSubTypeId: Int {
    case General = 10
    case Article = 11
    case Video = 12
    case Audio = 13
    case Image = 14
    case UserGenerated = 15
    case Social = 20
    case email = 21
    case chatIM = 22
    case SellingProduct = 30
    case AppStore = 31
    case ReviewSite = 32
    case TBD = 500
}

@objc public enum PlacementId: Int {
    case FeedContent = 1
    case AtomicContent = 2
    case OutsideContent = 3
    case RecommendationWidget = 4
    case TBD = 500
}

@objc public enum DataAsset: Int {
    case sponsored = 1
    case description = 2
    case rating = 3
    case likes = 4
    case downloads = 5
    case price = 6
    case saleprice = 7
    case phone = 8
    case address = 9
    case description2 = 10
    case displayurl = 11
    case ctatext = 12
    case XXX = 500
}


