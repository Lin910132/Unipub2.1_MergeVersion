//
//  YRSendComment.swift
//  Whoops
//
//  Created by naikun on 15/3/10.
//  Copyright (c) 2015y Li Jiatan. All rights reserved.
//

import Foundation

protocol YRRefreshCommentViewDelegate
{
    
    func refreshCommentView(refreshView:YRSendComment,didClickButton btn:UIButton)
}


class YRSendComment:UIView , UITextFieldDelegate{
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    var delegate:YRRefreshCommentViewDelegate!
    
    var postId:String = ""
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        commentText.delegate = self
        
        let width = UIScreen.mainScreen().bounds.width
//        var height = UIScreen.mainScreen().bounds.height
        self.sendButton.frame = CGRectMake(0, width - 10, 30, 30)
        
               
    }
    
    
   
    
       
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        let comment:String = self.commentText.text!
        if comment.characters.count > 30 {
            self.commentText.text = comment.substringToIndex(30)
            return false
        }
        return true
    }
   
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        var width = UIScreen.mainScreen().bounds.width
//        var height = UIScreen.mainScreen().bounds.height
//        self.frame = CGRectMake(0, height * 0.5 , width, 50)
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.commentText) {
            
            textField.resignFirstResponder()
            //            self.view.becomeFirstResponder()
        }
        return true;
    }

    func setCurrentPostId(postId:String){
        self.postId = postId
    }
    
    @IBAction func sendBtnClicked(sender:UIButton)
    {
        let content = commentText.text!
        if content.isEmpty{
//            UIView.showAlertView("WARNING",message:"Comment should not be empty")
            return
        }
        
        let url = FileUtility.getUrlDomain() + "comment/add?"
        let paraData = "content=\(content)&postId=\(postId)&uid=\(FileUtility.getUserId())"
        
        YRHttpRequest.postWithURL(urlString: url, paramData: paraData)
        
        commentText.text = ""
        self.delegate.refreshCommentView(self,didClickButton:sender)
        self.commentText.resignFirstResponder()
    }
    
}