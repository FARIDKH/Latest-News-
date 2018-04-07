//
//  ViewController.swift
//  Latest News
//
//  Created by Farid Qanbarov on 4/5/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UIScrollViewDelegate , UISearchBarDelegate{
    
    var news : [News] = [News]()
    
    let baseURL = "https://newsapi.org/v2/everything"
    let apiKey = "e9ca98864edd446c844028aa29c1798d"
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollSlideView: UIScrollView!
    
    @IBAction func searchIsClicked(_ sender: Any) {
        searchBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let slides = createSlider()
        setupScrollSlideView(slides: slides)
        
        scrollSlideView.delegate = self
        view.bringSubview(toFront: pageControl)
        view.bringSubview(toFront: searchBar)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .red
        searchBar.isHidden = true
        searchBar.delegate = self
    }

    func createSlider() -> [Slide] {
//        let slide1 : Slide = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! Slide
//        slide1.quoteLabel.text = "Slide1"
//        slide1.quoteImage.image = UIImage(named: "placeholder")
//        slide1.quoteTextView.textColor = .black
//        slide1.quoteTextView.text = "YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH"
//        let slide2 : Slide = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! Slide
//        slide2.quoteImage.image = UIImage(named: "placeholder")
//        slide2.quoteTextView.textColor = .white
//        slide2.quoteTextView.text = "YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH YOU SEEM TO HAVE CAUGHT ME IN THE MIDDLE OF MY MINERAL BATH"
//        return [slide1,slide2]
        
        var slides = [Slide]()
        for i in 0 ..< news.count {
            slides.append(Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! Slide)
        }
        pageControl.numberOfPages = news.count
        setupScrollSlideView(slides: slides)
        return slides
    }
    
    func setupScrollSlideView(slides: [Slide]) {
        print("setupscrollslideview is called")
        scrollSlideView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollSlideView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollSlideView.isPagingEnabled = true
        scrollSlideView.isDirectionalLockEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slides[i].quoteLabel.textColor = .black
            
            slides[i].quoteLabel.text = news[i].title
            slides[i].quoteTextView.text = news[i].text
            if let imageURL = news[i].imageURL {
                Alamofire.request(imageURL).responseData(completionHandler: { (response) in
                    print(response.data)
                    DispatchQueue.main.async {
                        slides[i].quoteImage.image = UIImage(data: response.data!)
                    }
                    
                })
            } else {
                slides[i].quoteImage.image = UIImage(named: "placeholder")
            }
            scrollSlideView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(pageIndex)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        news = [News]()
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            let params = [
                "q" : text,
                "apiKey" : apiKey,
                "sources" : "cnn"
            ]
            let request = Alamofire.request(baseURL, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
                let newsJSON = JSON(response.value)
                self.parseJSON(json : newsJSON)
                self.createSlider()
            })
        }
    }
    
    
    func parseJSON(json : JSON) {
        print("Json result is received")
        for i in 0 ..< json["articles"].count {
            let news = News()
            news.title = json["articles"][i]["title"].stringValue
            news.text = json["articles"][i]["description"].stringValue
            news.imageURL = json["articles"][i]["urlToImage"].stringValue
            
            if i > 20 {
                break
            } else {
                self.news.append(news)
            }
        }
    }


}

