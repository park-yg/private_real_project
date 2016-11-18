using UnityEngine;
using System.Collections;

public class manager : MonoBehaviour {
    
    public static bool isAndroid = true;

	//User Mode
	public enum UserMode { Play, Upload };
	public static UserMode userMode = UserMode.Upload;

	//State(true:on, false:off)
	//(1)Play mode
    public static bool playState = false; //when watching the message streaming
	//(2)Upload mode
	public static bool uploadState = false; //when sending the message streaming 

	//Audio
    public static int audioFreq = 24000; //sample rate
    public static int stereoType = 2; //1:mono, 2:stereo

    public static int imageQuality = 0; //0:png, 1~100:jpg quality



    public static void init()
    {
        if(isAndroid)
        {

        }
    }

    public static void StartUploading()
    {
        if (isAndroid)
        {

        }
    }

    public static void StopRecording()
    {
        if (isAndroid)
        {

        }
    }





}
