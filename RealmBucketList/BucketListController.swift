
import Foundation
import RealmSwift

class BucketListController {
    
    var bucketList = [NSDictionary]()
    
    func create(title: String) {
        let realm = try! Realm()
        
        //データの書き込み
        try! realm.write {
            
            let bucketList = BucketList()
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            bucketList.id = (realm.objects(BucketList.self).max(ofProperty: "id") as Int? ?? 0) + 1
            bucketList.title = title
            bucketList.date = formatter.string(from: now as Date)
            
            realm.add(bucketList)
        }
    }
    
    func getAll() {
        let realm = try! Realm()
        
        let bucketList = realm.objects(BucketList.self)
        
        for value in bucketList {
            let bucket = ["id": value.id, "title": value.title, "date": value.date] as NSDictionary
            
            self.bucketList.append(bucket)
        }
    }
    
    func getDataFrom(id: Int) -> BucketList {
        let realm = try! Realm()
        
        let bucket = realm.objects(BucketList.self).filter("id  = \(id)").first
        
        return bucket!
    }
    
    func update(targetID: Int, title: String) {
        let realm = try! Realm()
        
        let bucket = realm.objects(BucketList.self).filter("id  = \(targetID)").first
        
        try! realm.write() {
            bucket!.title = title
        }
    }

    
    func delete(targetID: Int) {
        let realm = try! Realm()
        
        let bucket = realm.objects(BucketList.self).filter("id  = \(targetID)").first
        
        try! realm.write {
            realm.delete(bucket!)
        }
    }
}
