
import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btn: UIButton!
    var bucketList = BucketListController()
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if id == Int() {
            btn.setTitle("add", for: .normal)
        } else {
            btn.setTitle("update", for: .normal)
            let bucket = bucketList.getDataFrom(id: id)
            textField.text! = bucket.title
        }
        
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        if btn.titleLabel!.text == "add" {
            bucketList.create(title: textField.text!)
        } else {
            bucketList.update(targetID: id, title: textField.text!)
        }
        
        textField.text = ""
        id = Int()
        
        dismiss(animated: true, completion: nil)
    }

}
