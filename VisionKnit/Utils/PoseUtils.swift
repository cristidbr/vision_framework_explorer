//
//  PoseUtils.swift
//  VisionKnit
//

import Foundation
import Vision

//TODO: Remove white space and ";"
extension VNRecognizedPoint
{
    public func toCGPoint( ) -> CGPoint
    {
        return CGPoint( x: self.x, y: 1.0 - self.y );
    }
}
//TODO: Remove white space and ";"
extension VNHumanHandPoseObservation
{
    static let drawableConnections: [ [ VNHumanHandPoseObservation.JointName ] ] =
    [
        [ .thumbTip, .thumbIP, .thumbMP, .thumbCMC, .wrist ],
        [ .indexTip, .indexDIP, .indexPIP, .indexMCP, .wrist ],
        [ .middleTip, .middleDIP, .middlePIP, .middleMCP, .wrist ],
        [ .ringTip, .ringDIP, .ringPIP, .ringMCP, .wrist ],
        [ .littleTip, .littleDIP, .littlePIP, .littleMCP, .wrist ],
    ]
    
    public func toJointsDictionary( ) -> [ VNHumanHandPoseObservation.JointName: VNRecognizedPoint ]
    {
        var joints: [ VNHumanHandPoseObservation.JointName: VNRecognizedPoint ] = [:];
        
        do
        {
            joints = try self.recognizedPoints( .all );
        }
        catch {}
        
        joints = joints.filter {
            $0.value.confidence > 0.5
        }
        
        return joints;
    }
    
    public func toCGPointsInArea( areaSize: CGSize ) -> [ CGPoint ]
    {
        let joints = self.toJointsDictionary();
        var points: [ CGPoint ] = [];
        
        for ( _, joint ) in joints
        {
            let pt = joint.toCGPoint();
            
            points.append( CGPoint( x: pt.x * areaSize.width, y: pt.y * areaSize.height ) );
        }
        
        return points;
    }
    
    public func toDrawableCGPath( ) -> CGPath
    {
        let joints = self.toJointsDictionary();
        let path = CGMutablePath();
        
        for connected in VNHumanHandPoseObservation.drawableConnections
        {
            for idx in 0..<connected.count - 1
            {
                let sn = connected[ idx ], en = connected[ idx + 1 ];
                let sj = joints[ sn ], ej = joints[ en ];
                
                if let sp = sj?.toCGPoint()
                {
                    if let ep = ej?.toCGPoint()
                    {
                        path.move( to: sp )
                        path.addLine( to: ep )
                        path.closeSubpath()
                    }
                }
            }
        }
    
        return path
    }
}
//TODO: Remove white space and ";"
extension VNHumanBodyPoseObservation
{
    static let drawableConnections: [ [ VNHumanBodyPoseObservation.JointName ] ] =
    [
        [ .rightEar, .rightEye, .nose, .leftEye, .leftEar ],
        [ .rightWrist, .rightElbow, .rightShoulder, .neck, .leftShoulder, .leftElbow, .leftWrist ],
        [ .rightAnkle, .rightKnee, .rightHip ],
        [ .leftAnkle, .leftKnee, .leftHip ],
        [ .rightShoulder, .rightHip, .root, .leftHip, .leftShoulder ],
        [ .neck, .nose ]
    ]
    
    public func toJointsDictionary( ) -> [ VNHumanBodyPoseObservation.JointName: VNRecognizedPoint ]
    {
        var joints: [ VNHumanBodyPoseObservation.JointName: VNRecognizedPoint ] = [:];
        
        do
        {
            joints = try self.recognizedPoints( .all );
        }
        catch {}
        
        joints = joints.filter {
            $0.value.confidence > 0.5
        }
        
        return joints;
    }
    
    public func toCGPointsInArea( areaSize: CGSize ) -> [ CGPoint ]
    {
        let joints = self.toJointsDictionary();
        var points: [ CGPoint ] = [];
        
        for ( _, joint ) in joints
        {
            let pt = joint.toCGPoint();
            
            points.append( CGPoint( x: pt.x * areaSize.width, y: pt.y * areaSize.height ) );
        }
        
        return points;
    }
    
    public func toDrawableCGPath( ) -> CGPath
    {
        let joints = self.toJointsDictionary();
        let path = CGMutablePath();
        
        for connected in VNHumanBodyPoseObservation.drawableConnections
        {
            for idx in 0..<connected.count - 1
            {
                let sn = connected[ idx ], en = connected[ idx + 1 ];
                let sj = joints[ sn ], ej = joints[ en ];
                
                if let sp = sj?.toCGPoint()
                {
                    if let ep = ej?.toCGPoint()
                    {
                        path.move( to: sp )
                        path.addLine( to: ep )
                        path.closeSubpath()
                    }
                }
            }
        }
    
        return path
    }
}
