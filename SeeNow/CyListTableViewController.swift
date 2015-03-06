

import UIKit

class CyListTableViewController: UITableViewController,HttpProtocol {
    //接收数据
    var CyList:NSArray = NSArray()
    //评审组ID
    var PszId = 280
    
    var eHttp:HttpController = HttpController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CyListUrl = GetService + "which=CyList&PszId=\(PszId)"
        eHttp.delegate = self
        eHttp.onSearch(CyListUrl)
        
    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        if(result.allKeys[0] as NSString == "CyList"){
            println(result)
            if result["CyList"] != nil{
                self.CyList = result["CyList"] as NSArray
                self.tableView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return CyList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CyCell", forIndexPath: indexPath) as UITableViewCell
        let rowData = CyList[indexPath.row] as NSDictionary
        cell.textLabel?.text = rowData["Xm_zw"] as NSString
        cell.detailTextLabel?.text = rowData["Qymc"] as NSString

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
