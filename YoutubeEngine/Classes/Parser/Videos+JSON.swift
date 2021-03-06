import Foundation
import SwiftyJSON

extension Video: JSONRepresentable {
   init?(json: JSON) {
      guard let id = json["id"].string else {
         return nil
      }

      self.id = id
      self.snippet = Snippet(json: json[Part.Snippet.parameterValue])
      self.contentDetails = VideoContentDetails(json: json[Part.ContentDetails.parameterValue])
      self.statistics = VideoStatistics(json: json[Part.Statistics.parameterValue])
   }
}

extension VideoStatistics: JSONRepresentable {
   init?(json: JSON) {
      self.views = json["viewCount"].string.flatMap { Int($0) }
      self.likes = json["likeCount"].string.flatMap { Int($0) }
      self.dislikes = json["dislikeCount"].string.flatMap { Int($0) }
   }
}

extension VideoContentDetails: JSONRepresentable {
   init?(json: JSON) {
      guard let duration = json["duration"].duration else {
         return nil
      }
      self.duration = duration
   }
}

private extension JSON {
   var duration: NSDateComponents? {
      return self.string.flatMap { NSDateComponents(ISO8601String: $0) }
   }
}
