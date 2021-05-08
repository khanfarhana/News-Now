//
//  ViewController.swift
//  Api_Task
//
//  Created by Farhana Khan on 11/04/21.
//

import UIKit

class HeadLineVC: UIViewController {
    var dataH = [NSDictionary]()
    //var headline = String
    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.title = "LAtest"
        
        self.title = "Latest Business News"
        apiCall()
    }
    func apiCall(){
        
        let url = URL(string: "https://stockaxis.com/Webservices/android/index.aspx?action=view&activity=stocknews&Records=20")
        let urlReq = URLRequest(url: url!)
        URLSession.shared.dataTask(with: urlReq) { (data, resp, err) in
            if let error = err {
                print("\(error.localizedDescription)")
            }
            else if let dataResp = data{
                do{
                    let jsonResp = try JSONSerialization.jsonObject(with: dataResp, options: .mutableContainers) as! NSDictionary
                    self.dataH = jsonResp.value(forKey: "data") as! [NSDictionary]
                    // print(jsonResp)
                    print("data here \(self.dataH)")
                    
                }
                catch{
                    print("exception")
                }
                DispatchQueue.main.async {
                    self.TV.reloadData()
                }
            }
        }.resume()
    }
    
}
extension HeadLineVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        lb.text = "News"
        lb.textAlignment = .center
        lb.backgroundColor = UIColor.darkGray
        lb.textColor = UIColor.black
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataH.count
        //   return headline.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        // return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTVC
        cell.headerLb.text = dataH[indexPath.row].value(forKey: "Headline") as? String ?? ""
        cell.timeLb.text = dataH[indexPath.row].value(forKey: "date") as? String ?? ""
        cell.timeLb.textColor = UIColor.gray
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Hello! User", message: "Do you want to read the news?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }
        let News = UIAlertAction(title: "Read News", style: .default) { (action) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! DetailNewsVC
            vc.headingVar = self.dataH[indexPath.row].value(forKey: "Headline") as? String ?? ""
            let news = self.dataH[indexPath.row].value(forKey: "Detail_News") as? String ?? ""
            vc.timeVar = self.dataH[indexPath.row].value(forKey: "date") as? String ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            vc.newVar = news
            // self.present(vc, animated: true)
        }
        alert.addAction(News)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
