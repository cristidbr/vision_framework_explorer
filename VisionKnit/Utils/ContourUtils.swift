//
//  ContourUtils.swift
//  VisionKnit
//

import Foundation
import Vision

//TODO: Remove white space and ";"
extension VNContoursObservation
{
    func toDrawableCGPaths( ) -> ( CGPath, CGPath )
    {
        let top_path = CGMutablePath(), sub_path = CGMutablePath();
        var transform = CGAffineTransform( scaleX: 1.0, y: -1.0 )
            .concatenating( CGAffineTransform( translationX: 0, y: 1.0 ) )
        
        let top_contours = self.topLevelContours;
        
        for top_contour in top_contours
        {
            top_path.addPath( top_contour.normalizedPath );
            
            let sub_contours = top_contour.childContours;
            
            for sub_contour in sub_contours
            {
                sub_path.addPath( sub_contour.normalizedPath );
            }
        }
        
        return (
            top_path.copy( using: &transform ) ?? top_path,
            sub_path.copy( using: &transform ) ?? sub_path
        );
    }
}
