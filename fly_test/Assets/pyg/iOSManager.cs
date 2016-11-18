using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class iOSManager : MonoBehaviour {


    public static iOSManager instance;


    [DllImport("__Internal")] private static extern void initStream();
	[DllImport("__Internal")] private static extern void startStream();
	[DllImport("__Internal")] private static extern void outputCapturing(byte[] bytes, int size, long timestamp);
	[DllImport("__Internal")] private static extern void outputAudio(float[] data, int data_size, long timestamp);
	[DllImport("__Internal")] private static extern void stopStream();


	void Start()
	{
		instance = this;
	}
		
	public static void InitStream()
	{
		initStream();
	}

	public static void StartStream()
	{
		startStream();
	}
		
	public static void OutputCapturing(byte[] bytes, long timestamp)
	{
		outputCapturing(bytes, bytes.Length, timestamp);
	}
		
	public static void OutputAudio(float[] data, int data_size, long timestamp)
	{
		outputAudio(data, data_size, timestamp);
	}

	public static void StopStream()
	{
		stopStream ();
	}

}
