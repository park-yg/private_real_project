using UnityEngine;
using System.Collections;

public class SetupMicrophone : MonoBehaviour {

	// Use this for initialization
	IEnumerator Start () {
        var audio = GetComponent<AudioSource>();
        if (Microphone.devices.Length == 0)
            yield break;
		int outputSampleRate = AudioSettings.outputSampleRate;
		#if UNITY_IOS
		outputSampleRate = 24000;
		#elif UNITY_ANDROID
		outputSampleRate = manager.audioFreq;
		#endif

		audio.clip = Microphone.Start(null, true, 5, outputSampleRate);
        while (Microphone.GetPosition(null) <= 0) {
            yield return 0;
        }
        //audio.Play();
    }
}
