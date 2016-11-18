using UnityEngine;
using System.Collections;
using System;

public class AndroidComunicator : MonoBehaviour {

    public static AndroidJavaObject androidJavaObject;

    public static int frequence=0;

    void Start()
    {
        // Unity 에서 Android 접근 하기 위해 생성자를 초기화
        
        //call_android_Init();
        //call_getFrequence();
    }

    // Update is called once per frame
    void Update () {	
	}

    public static void call_android_Init()
    {
        manager.imageQuality = androidJavaObject.Call<int>("init");

        //Texture2D td2 = new Texture2D(2,2);
        
    }

    public static void call_android_startUploading()
    {
        androidJavaObject.Call("startUploading","prX","prY","orX", "orY", "mode");
    }

    public static void call_android_stopUploading()
    {
        androidJavaObject.Call("stopUploading");
    }

    public static void call_android_getFrameFromUnity(byte[] imageData)
    {
        androidJavaObject.Call("getFrameFromUnity", imageData);
    }

    public static void call_android_getAudioFromUnity(byte[] audioData)
    {        
        androidJavaObject.Call("getAudioFromUnity", audioData);
    }
    

    public static void call_getFrequence()
    {   
        manager.audioFreq= androidJavaObject.Call<int>("getAudioFrequence");
    }

    public static void call_android_getAudioFromUnity_float(float[] f)
    {
        //Debug.Log("f.Length:" + f.Length);
        
        androidJavaObject.Call("getAudioFromUnity_float", f);
    }


}
