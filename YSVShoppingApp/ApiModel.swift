
import Foundation


protocol ApiModelProtocol: class {
    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType)
    
}



class ApiModel: NSObject, URLSessionDataDelegate {
    
    //properties
    

    weak var apiItemDelegate : ApiModelProtocol!
    var data : NSMutableData = NSMutableData()
    
    //let urlPath: String = "http://yusufyilmaz.website/" //this will be changed to the path where service.php lives
    
    let urlPath: String = "http://yusufyilmz.com/api/" //this will be changed to the path where service.php lives

    
    func addUser(userModel : UserModel){
        let userDict = userModel.toDictionary()
        
        postData2(parameters: userDict, urlString: urlPath + "adduser")
        
    }
    
    func loginUser() {
        
    }
    
    func registerUser(email: String, name: String, password: String, confirmPassword: String) {
        
        var dic = Dictionary<String, String>()
        dic["Email"] = email
        dic["Password"] = password
        dic["ConfirmPassword"] = confirmPassword

        postData2(parameters: dic, urlString: urlPath + "registeruser")

        
    }
    
    func loginUser(email: String, name: String, password: String, rememberMe: String) {
        
        var dic = Dictionary<String, String>()
        dic["Email"] = email
        dic["Password"] = password
        dic["RememberMe"] = rememberMe
        
        postData2(parameters: dic, urlString: urlPath + "loginuser")
        
        
    }
    
    
    
    func getProductsWithCollectionId(id : String) {
        
        let urlMethod: String = "getproductswithcollectionid/\(id)"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var jsonElement: NSDictionary = NSDictionary()
            var products = [ProductModel]()
            
            for result in jsonResult {
                jsonElement = result as! NSDictionary
                let product = self.convertProduct(jsonElement: jsonElement)
                products.append(product)
            }
            
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: products, itemType: SearchItemType.Product)
            })
        })

    }
    
    func getProductsWithBrandId(id : String) {
        
        let urlMethod: String = "getproductswithbrandid/\(id)"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var jsonElement: NSDictionary = NSDictionary()
            var products = [ProductModel]()
            
            for result in jsonResult {
                jsonElement = result as! NSDictionary
                let product = self.convertProduct(jsonElement: jsonElement)
                products.append(product)
            }
            
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: products, itemType: SearchItemType.Product)
            })
        })
        
    }


    func getAllProducts() {
        
        let urlMethod: String = "GetAllProducts"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var element: NSDictionary = NSDictionary()
            var products = [ProductModel]()
            
            for result in jsonResult {
                element = result as! NSDictionary
                let product = self.convertProduct(jsonElement: element)
                products.append(product)
            }
    
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: products, itemType: SearchItemType.Product)
            })
        })
    }
    
    func convertProduct (jsonElement : NSDictionary) -> ProductModel {
        
        let product = ProductModel()

        
        if let description = jsonElement["Description"] as? String,
            let title = jsonElement["Title"] as? String,
            let slug = jsonElement["Slug"] as? String,
            let status = jsonElement["Status"] as? NSNumber,
            let id = jsonElement["ProductId"] as? NSNumber,
            let collectionid = jsonElement["CollectionId"] as? NSNumber,
            let brandid = jsonElement["BrandId"] as? NSNumber,
            let price = jsonElement["Price"] as? NSNumber,
            let stock = jsonElement["Stock"] as? NSNumber,
            let imageName = jsonElement["ImageName"] as? String,
            let imageContent = jsonElement["ImageContent"] as? String
        {
            product.ID = Int(id)
            product.Description = description
            product.Status = Int(status)
            product.Slug = slug
            product.Title = title
            product.BrandId = Int(brandid)
            product.CollectionId = Int(collectionid)
            product.Price = Double(price)
            product.Stock = Int(stock)
            product.ImageName = imageName
            product.ImageContent = NSData(base64Encoded: imageContent, options: [])
        }
        
        return product
    }
    
    
    
    
    
    func getAllMainHeads() {
        
        let urlMethod: String = "getallmainheads"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var jsonElement: NSDictionary = NSDictionary()
            var mainHeads = [MainHeadModel]()
            
            for result in jsonResult {
                jsonElement = result as! NSDictionary
                
                let mainHead = MainHeadModel()
                
                if let description = jsonElement["Description"] as? String,
                    let title = jsonElement["Title"] as? String,
                    let slug = jsonElement["Slug"] as? String,
                    let status = jsonElement["Status"] as? NSNumber,
                    let imageName = jsonElement["ImageName"] as? String,
                    let imageContent = jsonElement["ImageContent"] as? String,
                    let id = jsonElement["MainHeadId"] as? NSNumber
                {
                    mainHead.ID = Int(id)
                    mainHead.Description = description
                    mainHead.Status = Int(status)
                    mainHead.Slug = slug
                    mainHead.Title = title
                    mainHead.ImageName = imageName
                    mainHead.ImageContent = NSData(base64Encoded: imageContent, options: [])
                    
                }
                
                mainHeads.append(mainHead)
                
            }
            
            
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: mainHeads, itemType: SearchItemType.MainHead)
            })
            
            
            
        })
        
    }

    
    
    
    func getAllMainCollections() {
        
        let urlMethod: String = "getallmaincollections"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var jsonElement: NSDictionary = NSDictionary()
            var collections = [MainCollectionModel]()
            
            for result in jsonResult {
                jsonElement = result as! NSDictionary
                
                let collection = MainCollectionModel()
                
                if let description = jsonElement["Description"] as? String,
                    let title = jsonElement["Title"] as? String,
                    let slug = jsonElement["Slug"] as? String,
                    let status = jsonElement["Status"] as? NSNumber,
                    let imageName = jsonElement["ImageName"] as? String,
                    let imageContent = jsonElement["ImageContent"] as? String,
                    let id = jsonElement["MainCollectionId"] as? NSNumber
                {
                    collection.ID = Int(id)
                    collection.Description = description
                    collection.Status = Int(status)
                    collection.Slug = slug
                    collection.Title = title
                    collection.ImageName = imageName
                    collection.ImageContent = NSData(base64Encoded: imageContent, options: [])
                    
                }
                
                collections.append(collection)
                
            }
            
        
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: collections, itemType: SearchItemType.MainCollection)
            })
            
           
        })

    }
    
   
    
    func getAllCollections() {
        
        let urlMethod: String = "getallcollections"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
            
            var jsonElement: NSDictionary = NSDictionary()
            var collections = [CollectionModel]()

            for result in jsonResult {
                jsonElement = result as! NSDictionary
                
                let collection = CollectionModel()
                
                if let description = jsonElement["Description"] as? String,
                    let title = jsonElement["Title"] as? String,
                    let slug = jsonElement["Slug"] as? String,
                    let status = jsonElement["Status"] as? NSNumber,
                    let imageName = jsonElement["ImageName"] as? String,
                    let imageContent = jsonElement["ImageContent"] as? String,
                    let id = jsonElement["CollectionId"] as? NSNumber
                {
                    collection.ID = Int(id)
                    collection.Description = description
                    collection.Status = Int(status)
                    collection.Slug = slug
                    collection.Title = title
                    collection.ImageName = imageName
                    collection.ImageContent = NSData(base64Encoded: imageContent, options: [])

                }
                
                collections.append(collection)
                
            }
            
        
            
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: collections, itemType: SearchItemType.Collection)
            })
            
        })
    }
    

    
    
    func getAllBrands() {
        
        let urlMethod: String = "getallbrands"
        
        downloadItems(urlMethod: urlMethod, completion: { (jsonResult) in
        
            var jsonElement: NSDictionary = NSDictionary()
            var brands = [BrandModel]()
            
            for result in jsonResult {
                jsonElement = result as! NSDictionary
                
                let brand = BrandModel()
                
                if let description = jsonElement["Description"] as? String,
                    let title = jsonElement["Title"] as? String,
                    let slug = jsonElement["Slug"] as? String,
                    let status = jsonElement["Status"] as? NSNumber,
                    let imageName = jsonElement["ImageName"] as? String,
                    let imageContent = jsonElement["ImageContent"] as? String,
                    let id = jsonElement["BrandId"] as? NSNumber
                {
                    brand.ID = Int(id)
                    brand.Description = description
                    brand.Status = Int(status)
                    brand.Slug = slug
                    brand.Title = title
                    brand.ImageName = imageName
                    brand.ImageContent = NSData(base64Encoded: imageContent, options: [])
                }
               
                brands.append(brand)
                
            }
            
            
            DispatchQueue.main.async( execute: {
                
                self.apiItemDelegate.itemsDownloaded(items: brands, itemType: SearchItemType.Brand)
            })
        })
    }
    
    

    
    func downloadItems (urlMethod: String, completion: @escaping (_ result: [Any]) -> Void ) {
        // Set up the URL request
        let todoEndpoint: String = urlPath  + urlMethod
       
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }

            
            // parse the result as JSON, since that's what the API provides
            do {
            
             //   self.getData()
                
                
                guard let jsonResult = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                completion(jsonResult as! [Any])

            } catch   {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
    
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
  
        self.data.append(data);
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            //self.parseJSON()
        }
        
    }
    
    func postData2 (parameters : Dictionary<String, String>, urlString: String) {
        
        
        var request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

        // or if you think the conversion might actually fail (which is unlikely if you built `parameters` yourself)
        //
        // do {
        //    request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        // } catch {
        //    print(error)
        // }
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error: \(error)")
                return
            }
            
            // this, on the other hand, can quite easily fail if there's a server error, so you definitely
            // want to wrap this in `do`-`try`-`catch`:
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    print("Success: \(success)")
                } else {
                    let jsonStr = String(data: data, encoding: .utf8)    // No error thrown, but not dictionary
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data, encoding: .utf8)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        
        task.resume()


    }
    
    func postData () {
        
        var request = URLRequest(url: URL(string: "http://www.thisismylink.com/postName.php")!)
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    func getData () {
        
        let url = URL(string: "http://yusufyilmz.com/api/getallbrands")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error ?? "no error")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            if (jsonObject is NSArray) {
                print("its an array!")
                var jsonArray = (jsonObject as! [Any])
                print("jsonArray - \(jsonArray)")
            }
            else {
                print("its probably a dictionary")
                var jsonDictionary = (jsonObject as! [AnyHashable: Any])
                print("jsonDictionary - \(jsonDictionary)")
            }

     
                
          //  print(json)
        }
        
        task.resume()
    }
    
}

//
//func sendLoginInfo(username: String, password: String) -> String{
//    if let url = URL(string: "myphpurl"){
//        let request = NSMutableURLRequest(url:url)
//        request.httpMethod = "POST";// Compose a query string
//        let postString = "?username=\(myUsername)&password=\(myPassword)"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//        let task = URLSession.shared.dataTask(with:request as URLRequest){
//            data, response, error in
//            
//            if error != nil{
//                print("1\(error)")
//            }
//            else{
//                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                print("response string = \(responseString!)")
//            }
//            
//            do {
//                
//                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
//                    
//                    // Print out dictionary
//                    print(convertedJsonIntoDict)
//                    
//                    // Get value by key
//                    let firstNameValue = (convertedJsonIntoDict[0] as! NSDictionary)["username"] as? String
//                    print("here = \(firstNameValue!)")
//                    
//                }
//                else{
//                    print("here")
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
//    return ""
//}
