//
//  ViewController.m
//  LFLiveKit
//
//  Created by JiJeongMin on 2016. 10. 31..
//  Copyright © 2016년 WonderPeople. All rights reserved.
//

//(1) LFLiveAudioSampleRate_24000Hz
//(2)
/*
- (void)pushVideo:(nullable CVPixelBufferRef)pixelBuffer withTimestamp:(long)timestamp{
    if(self.captureType & LFLiveInputMaskVideo){
        if (self.uploading) [self.videoEncoder encodeVideoData:pixelBuffer timeStamp:timestamp];
    }
}

- (void)pushAudio:(nullable NSData*)audioData withTimestamp:(long)timestamp{
    if(self.captureType & LFLiveInputMaskAudio){
        if (self.uploading) [self.audioEncoder encodeAudioData:audioData timeStamp:timestamp];
    }
}
*/

#import "LFLiveSession.h"


@interface LFLiveKitPlugin : UIViewController <LFLiveSessionDelegate>

@property (nonatomic) LFLiveSession *session;
@property int outputAudioSampleRate;

@end


@implementation LFLiveKitPlugin


#pragma mark - Life Cycle

/**
 * Singleton
 */
+ (id)sharedManager {
    static dispatch_once_t pred;
    static LFLiveKitPlugin *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[LFLiveKitPlugin alloc] init];
    });
    return shared;
}


/**
 * Init Streaming
 */
-(void)initStream{
    //[self requestAccessForVideo];
    //[self requestAccessForAudio];
}


/**
 * Init LFLiveSession
 */
- (LFLiveSession*)session {
    if (!_session) {
        
        //Own custom high-quality audio 96K resolution set to 540 * 960 direction vertical screen
        LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
        audioConfiguration.numberOfChannels = 2;
        //audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
        audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_24000Hz;
        
        LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
        videoConfiguration.videoSize = CGSizeMake(360, 640);
        //videoConfiguration.videoBitRate = 800*1024;
        //videoConfiguration.videoMaxBitRate = 1000*1024;
        //videoConfiguration.videoMinBitRate = 500*1024;
        //videoConfiguration.videoFrameRate = 24;
        //videoConfiguration.videoMaxKeyframeInterval = 48;
        videoConfiguration.sessionPreset = LFCaptureSessionPreset360x640;
        
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration captureType:LFLiveInputMaskAll];
        //LFLiveInputMaskAll, LFLiveCaptureMaskAudioInputVideo
        
        
        
        //Default resolution 368 * 640 Audio: 44.1 iphone6 above 48 dual-channel vertical screen direction
        /*
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(640, 360);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 24;
         videoConfiguration.videoMaxKeyframeInterval = 48;
         videoConfiguration.outputImageOrientation = UIInterfaceOrientationLandscapeLeft;
         videoConfiguration.autorotate = NO;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:videoConfiguration captureType:LFLiveCaptureDefaultMask];
        */
        
        //Customize your own mono
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 1;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_64Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        */
        
        //Customize your own high-quality audio 96K
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        */
        
        //Own custom high-quality audio 96K resolution set to 540 * 960 direction vertical screen
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(540, 960);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 24;
         videoConfiguration.videoMaxKeyframeInterval = 48;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset540x960;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
        */
        
        //Own custom high-quality audio 128K resolution is set to 720 * 1280 direction vertical screen
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.landscape = NO;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset360x640;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
        */
        
        // Own custom high-quality audio 128K resolution set to 720 * 1280 direction horizontal screen
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(1280, 720);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.landscape = YES;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
        */
        //_session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
        
        _session.delegate = self;
        
        
        
        
        
        
        //Local storage
        /*
         _session.saveLocalVideo = YES;
         NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.mp4"];
         unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
         NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
         _session.saveLocalVideoPath = movieURL;
         
         UIImageView *imageView = [[UIImageView alloc] init];
         imageView.alpha = 0.8;
         imageView.frame = CGRectMake(100, 100, 29, 29);
         imageView.image = [UIImage imageNamed:@"ios-29x29"];
         _session.warterMarkView = imageView;
        */
    }
    return _session;
}


/**
 * Start Streaming
 */
-(void)startStream{
    [self requestAccessForVideo];
    [self requestAccessForAudio];
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    //streamInfo.url = @"rtmp://591c26.entrypoint.cloud.wowza.com/app-99c2/f40ffe4b";
    streamInfo.url = @"rtmp://104.199.223.216:1935/liveorigin/myStream123";
    [self.session startLive:streamInfo];
}


/**
 * Stop Streaming
 */
-(void)stopStream{
    [self.session stopLive];
}




#pragma mark - Private

- (void)requestAccessForVideo {
    //__weak typeof(self) _self = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            // The license dialog does not appear and the license is initiated
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.session setRunning:NO];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            // Authorization has been opened, can continue
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.session setRunning:NO];
            });
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // The user explicitly denied the authorization, or the camera device was inaccessible
            break;
        default:
            break;
    }
}

- (void)requestAccessForAudio {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                //
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}


/**
 * 현재 이미지 파일 캡쳐
 */
-(void)outputCapturing:(const char**)bytes withSize:(int)size withTimestamp:(long)timespamp{
    UIImage *image = [UIImage imageWithData:[NSData dataWithBytes:bytes length:size]];
    if(!image) return;
    CVPixelBufferRef newPixelBuffer = [self pixelBufferFromCGImage:image.CGImage];
    if(!newPixelBuffer) return;
    [self.session pushVideo:newPixelBuffer withTimestamp:timespamp];
    CFRelease(newPixelBuffer);
    image = nil;
}


/**
 * 현재 오디오 캡쳐
 */
-(void)outputAudio:(float*)data withSize:(int)size withTimestamp:(long)timespamp{
    
    /*
    short data_short[size];
    for(int i=0; i<size; i++){
        data_short[size] = short(data[i]*100.0f);
    }
    Byte data_byte[size*2];
    for(int i=0; i<size; i++){
        data_byte[2*i] = (Byte)(data_short[i] & 0xff);
        data_byte[2*i+1] = (Byte)((data_short[i] >> 8) & 0xff);
    }
    */
    
    
    
    Byte *data_byte = new Byte[size*2];
    data_byte[0] = data_byte[1] = data[0];
    data_byte[2*(size-1)] = data_byte[2*(size-1)+1] = data[size-1];
    
    for(int i=1; i<size-1; i++){
        if(data[i]<-0.02 || 0.02<data[i]){
            //mean filter
            data_byte[2*i] = data_byte[2*i+1] = Byte((data[i-1]+data[i]+data[i+1])*40.0f); //42.0 = 127.0/3.0
            //data_byte[2*i] = data_byte[2*i+1] = Byte(data[i]*120.0f);
        }
        else{
            data_byte[2*i] = data_byte[2*i+1] = 0;
        }
    }
    NSData *data2= [NSData dataWithBytes:data_byte length:size*2];
    if(!data2) return;
    [self.session pushAudio:data2 withTimestamp:timespamp];
    data2 = nil;
    free(data_byte);
    
    /*
    Byte data_byte[size];
    
    for(int i=1; i<size-1; i++){
        //mean filter
        data_byte[i] = Byte((data[i-1]+data[i]+data[i+1])*42.0f); //42.0 = 127.0/3.0
    }
    
    
    NSData *data2= [NSData dataWithBytes:data_byte length:size];
    if(!data2) return;
    [self.session pushAudio:data2];
    data2 = nil;
    */
}




/**
 * Image to CVPixelBufferRef
 */
- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image{
    CGSize frameSize = CGSizeMake(CGImageGetWidth(image),
                                  CGImageGetHeight(image));
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey, [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status =
    CVPixelBufferCreate(
                        kCFAllocatorDefault, frameSize.width, frameSize.height,
                        kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef)options,
                        &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(
                                                 pxdata, frameSize.width, frameSize.height,
                                                 8, CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGBitmapByteOrder32Little |
                                                 kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    return pxbuffer;
}







#pragma mark - CallBack

- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state{
    
}
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}



@end






#pragma mark - Extern

extern "C"
{
    void initStream()
    {
        [[LFLiveKitPlugin sharedManager] initStream];
    }
    
    void startStream()
    {
        [[LFLiveKitPlugin sharedManager] startStream];
    }
    
    void outputCapturing(const char** bytes, int size, long timestamp)
    {
        [[LFLiveKitPlugin sharedManager] outputCapturing:bytes withSize:size withTimestamp:timestamp];
    }
    
    void audioSampleRate(int outputSampleRate)
    {
        [[LFLiveKitPlugin sharedManager] setOutputAudioSampleRate:outputSampleRate];
    }
    
    void outputAudio(float* data, int size, long timestamp)
    {
        [[LFLiveKitPlugin sharedManager] outputAudio:data withSize:size withTimestamp:timestamp];
    }
    
    void stopStream()
    {
        [[LFLiveKitPlugin sharedManager] stopStream];
    }
}




