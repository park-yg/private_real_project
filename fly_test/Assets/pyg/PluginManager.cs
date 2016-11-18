using UnityEngine;
using System.Collections;

public class PluginManager : MonoBehaviour {
	
	//Connect the session with server

    void Start()
    {
        Init();
    }

    public static void Init()
    {
        Debug.Log("init");

#if UNITY_IOS
        iOSManager.InitStream();
#elif UNITY_ANDROID
        //AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
        AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
        AndroidComunicator.androidJavaObject = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
        AndroidComunicator.call_android_Init();
        AndroidComunicator.call_getFrequence();

        #endif
    }

	//Start streaming
    public static void startUploading()
    {
        Debug.Log("startUploading");

		#if UNITY_IOS
        iOSManager.StartStream();
		#elif UNITY_ANDROID
        AndroidComunicator.call_android_startUploading();
		#endif
    }

	//Stop streaming
    public static void stopUploading()
    {
        Debug.Log("stopUploading");

#if UNITY_IOS
        iOSManager.StopStream(); 
#elif UNITY_ANDROID
        AndroidComunicator.call_android_stopUploading();
		#endif
    }
		
	//Get the current video frame
	public static void getFrameFromUnity(byte[] imageData, long timestamp = 0)
    {
		#if UNITY_IOS
		iOSManager.OutputCapturing(imageData, timestamp);
		#elif UNITY_ANDROID
        AndroidComunicator.call_android_getFrameFromUnity(imageData);
		#endif
    }

	//Set the audio setting 
	public static void setAudioSetting(int stereoType, int freq)
	{
		manager.stereoType = stereoType;
		manager.audioFreq = freq;
	}

	//Get the current audio data(byte)
	public static void getAudioFromUnity(byte[] audioData, long timestamp = 0)
    {
		#if UNITY_IOS
		//
		#elif UNITY_ANDROID
        AndroidComunicator.call_android_getAudioFromUnity(audioData);
		#endif
    }

	//Get the current audio data(float)
	public static void getAudioFromUnity_float(float []data, long timestamp = 0)
	{
        //Debug.Log("getAudioFromUnity_float");
		#if UNITY_IOS
		iOSManager.OutputAudio(data, data.Length, timestamp);
		#elif UNITY_ANDROID
		AndroidComunicator.call_android_getAudioFromUnity_float(data);
		#endif
	}


}
