using UnityEngine;
using System.Collections;

public class pngMaker : MonoBehaviour {
    public Camera render_camera;
    private Texture2D imageOverview;

    AudioClip c;

    void Start()
    {
        Debug.Log("start called");
        //yield return UploadPNG();


        //c = Microphone.Start(null, true, 5, 4096);
        

        imageOverview = new Texture2D(render_camera.targetTexture.width, render_camera.targetTexture.height, TextureFormat.RGB24, false);
    }


    byte[] MicTransferbyte= new byte[4096];
    byte[] MicDataSlot=new byte[40960];    
    int MicDataSeeker=0;    
    bool MicDataReady = false;

    bool once = false;

    void Update()
    {

            if (true)
            return;
            
    }


    float delay_to_screenshot = 10;

    void LateUpdate()
    {

        //if (delay_to_screenshot > 0) delay_to_screenshot -= Time.deltaTime;
        //else manager.uploadState = true;

        if (manager.uploadState)
        {
            if(manager.imageQuality==0)
                StartCoroutine("takeScreenshotWithAudio");
            else
                StartCoroutine("takeScreenshotByJPG");
        }
      

    }

    byte[] colorByte = null;

    int lastSample;

    

    IEnumerator takeScreenshotWithAudio()
    {
        yield return new WaitForEndOfFrame();

        Camera camera = render_camera;

        RenderTexture currentRenderTexture = RenderTexture.active;

        RenderTexture.active = camera.targetTexture;

        camera.Render();

        imageOverview.ReadPixels(new Rect(0, 0, camera.targetTexture.width, camera.targetTexture.height), 0, 0);

        imageOverview.Apply();

		RenderTexture.active = currentRenderTexture;

		//yield return new WaitForEndOfFrame ();

        byte[] imageBytes = imageOverview.EncodeToPNG();
        

		PluginManager.getFrameFromUnity(imageBytes, (long)(Time.realtimeSinceStartup*1000.0f));



    }

    IEnumerator takeScreenshotByJPG()
    {
        yield return new WaitForEndOfFrame();

        Camera camera = render_camera;

        RenderTexture currentRenderTexture = RenderTexture.active;

        RenderTexture.active = camera.targetTexture;

        camera.Render();

        imageOverview.ReadPixels(new Rect(0, 0, camera.targetTexture.width, camera.targetTexture.height), 0, 0);

        imageOverview.Apply();

        RenderTexture.active = currentRenderTexture;

        //yield return new WaitForEndOfFrame ();

        byte[] imageBytes = imageOverview.EncodeToJPG(manager.imageQuality);


        PluginManager.getFrameFromUnity(imageBytes, (long)(Time.realtimeSinceStartup * 1000.0f));



    }




    byte[] audioSampling()
    {
        byte[] ba=null;
        int pos = Microphone.GetPosition(null);
        int diff = pos - lastSample;

        //Debug.Log("audioSampling");


        if (diff > 0)
        {
            float[] samples = new float[diff * c.channels];

            //Debug.Log("AudioFloatSize:" + samples.Length);


            c.GetData(samples, lastSample);
            ba = ToByteArray(samples);

            //Debug.Log("byte length:" + ba.Length);

            //networkView.RPC("Send", RPCMode.Others, ba, c.channels);
        }
        lastSample = pos;
        return ba;
    }

    int readHead = 0;

    float[] audioSampling3()
    {
        Debug.Log("audioSampling3:" + c.samples);
        int writeHead = Microphone.GetPosition(null);
        int nFloatsToGet = (c.samples + writeHead - readHead) % c.samples;

        if (nFloatsToGet == 0)
            return null;

        float[] B = new float[nFloatsToGet];

        // If the read length from the offset is longer than the clip length,
        //   the read will wrap around and read the remaining samples
        //   from the start of the clip.
        c.GetData(B, readHead);

        readHead = (readHead + nFloatsToGet) % c.samples;
        return B;

    }

    byte[] audioSampling2()
    {
        int writeHead = Microphone.GetPosition(null);

        // Say audio.clip.samples (S)  = 100
        // if w=1, r=0, we want 1 sample.  ( S + 1 - 0 ) % S = 1 YES
        // if w=0, r=99, we want 1 sample.  ( S + 0 - 99 ) % S = 1 YES
        int nFloatsToGet = (c.samples + writeHead - readHead) % c.samples;

        if (nFloatsToGet == 0)
            return null;

        float[] B = new float[nFloatsToGet];

        // If the read length from the offset is longer than the clip length,
        //   the read will wrap around and read the remaining samples
        //   from the start of the clip.
        c.GetData(B, readHead);

        
        // !!! Send B to listeners

        readHead = (readHead + nFloatsToGet) % c.samples;
        return(ToByteArray(B));

    }

    public byte[] ToByteArray(float[] floatArray)
    {
        int len = floatArray.Length * 4;
        byte[] byteArray = new byte[len];
        int pos = 0;
        foreach (float f in floatArray)
        {
            byte[] data = System.BitConverter.GetBytes(f);
            System.Array.Copy(data, 0, byteArray, pos, 4);
            pos += 4;
        }
        return byteArray;
    }

    IEnumerator UploadPNG()
    {
        // We should only read the screen buffer after rendering is complete
        yield return new WaitForEndOfFrame();
        

        // Create a texture the size of the screen, RGB24 format
        int width = Screen.width;
        int height = Screen.height;
        //Texture2D tex = new Texture2D(width, height, TextureFormat.R, false);
        Texture2D tex = new Texture2D(400, 640, TextureFormat.RGB24, false);

        // Read screen contents into the texture
        //tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);

        tex.ReadPixels(new Rect(0, 0, 400, 640), 0, 0);

        tex.Apply();

        // Encode texture into PNG

        tex.Apply();

        // Encode texture into PNG
        byte[] bytes = tex.EncodeToPNG();
        Object.Destroy(tex);
        
        
    }
}
