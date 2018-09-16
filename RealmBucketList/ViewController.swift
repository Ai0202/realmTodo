//objectを作成 -> 新しいswiftファイル作成
//mainStoryBoard
//ファイルを分ける
//Extension


import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var bucketList = BucketListController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bucketList.bucketList.removeAll()
        bucketList.getAll()
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.bucketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = bucketList.bucketList[indexPath.row]["title"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let targetID = bucketList.bucketList[indexPath.row]["id"] as! Int
            bucketList.delete(targetID: targetID)
            
            //表示用の配列から削除
            bucketList.bucketList.remove(at: indexPath.row)
            
            //行が消える
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let id = bucketList.bucketList[indexPath.row]["id"]!
        performSegue(withIdentifier: "Segue", sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Segue" {
            let SecondVC = segue.destination as! SecondViewController
            SecondVC.id = sender as! Int
        }
    }
}
