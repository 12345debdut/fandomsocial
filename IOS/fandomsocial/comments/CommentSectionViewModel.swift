//
//  CommentSectionViewModel.swift
//  fandomsocial
//
//  Created by Debdut Saha on 04/01/26.
//

import Foundation
import Combine

class CommentSectionViewModel: ObservableObject {
    @Published var items: [CommentSectionItem] = []
    
    func fetchData() {
        items = [
            CommentSectionItem(image: "profile1", name: "atendmunds", comment: "Wow, your performance was amazing! You brought so much energy and authenticity—really stood out! Can’t wait to see more from you! 🎬👏 #TalentOnPoint", date: "23h ago", isLiked: false, likes: 492, replyCount: 160),
            CommentSectionItem(image: "profile2", name: "huge_me", comment: "Absolutely captivating! You brought so much passion and personality to this audition. Can’t wait to see what’s next! 🎥🔥 #AuditionMagic", date: "16h ago", isLiked: false, likes: 505, replyCount: 21),
            CommentSectionItem(image: "profile3", name: "huge_me", comment: "Every detail of your performance felt polished, expressive, and engaging. You showed real talent today, and I’m looking forward.", date: "19h ago", isLiked: false, likes: 357, replyCount: 54),
            CommentSectionItem(image: "profile4", name: "atendmunds", comment: "Absolutely captivating! You brought so much passion and personality to this audition. Can’t wait to see what’s next! 🎥🔥 #AuditionMagic", date: "23h ago", isLiked: false, likes: 345, replyCount: 65),
            CommentSectionItem(image: "profile1", name: "huge_me", comment: "Wow your performance was amazing! You brought so much energy and excitement to the game!", date: "23h ago", isLiked: false, likes: 243, replyCount: 54),
            CommentSectionItem(image: "profile2", name: "atendmunds", comment: "Wow, your performance was amazing! You brought so much energy and authenticity—really stood out! Can’t wait to see more from you! 🎬👏 #TalentOnPoint", date: "23h ago", isLiked: false, likes: 234, replyCount: 45),
        ]
    }
}
