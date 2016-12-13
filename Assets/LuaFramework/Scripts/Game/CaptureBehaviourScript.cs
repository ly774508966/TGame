using UnityEngine;
using System.Collections;
using System.IO;

public class CaptureBehaviourScript : MonoBehaviour {

    public Camera ca;
    public Rect rect;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

   public void CaptureCamera()
    {
        // 创建一个RenderTexture对象
        RenderTexture rt = new RenderTexture((int)rect.width, (int)rect.height, 0);
        // 临时设置相关相机的targetTexture为rt, 并手动渲染相关相机  
        ca.targetTexture = rt;
        ca.Render();
        //ps: --- 如果这样加上第二个相机，可以实现只截图某几个指定的相机一起看到的图像。  
        //ps: camera2.targetTexture = rt;  
        //ps: camera2.Render();  
        //ps: -------------------------------------------------------------------  

        // 激活这个rt, 并从中中读取像素。  
        RenderTexture.active = rt;
        Texture2D screenShot = new Texture2D((int)rect.width, (int)rect.height, TextureFormat.RGB24, false);
        screenShot.ReadPixels(rect, (int)rect.x, (int)rect.y,true);// 注：这个时候，它是从RenderTexture.active中读取像素  
        screenShot.Apply();
        //TextureScale.Point(screenShot, 1024, 768);
        // 重置相关参数，以使用camera继续在屏幕上显示  
        ca.targetTexture = null;
        //ps: camera2.targetTexture = null;  
        RenderTexture.active = null; // JC: added to avoid errors  
        GameObject.Destroy(rt);
        // 最后将这些纹理数据，成一个png图片文件  
        byte[] bytes = screenShot.EncodeToPNG();
        System.DateTime now = System.DateTime.Now;
        string filename = string.Format("image{0}{1}{2}{3}{4}{5}.png", now.Year, now.Month, now.Day, now.Hour, now.Minute, now.Second);
        string path_save = filename;
        string destination = "";
        if (Application.platform == RuntimePlatform.Android)
        {
            string origin = path_save;
            destination = "/mnt/sdcard/DCIM/ARphoto";
            if (!Directory.Exists(destination))
            {
                Directory.CreateDirectory(destination);
            }
            destination = destination + "/" + filename;
            path_save = destination;
        }

        string filename = Application.dataPath + "/Screenshot.png";
        System.IO.File.WriteAllBytes(filename, bytes);
        Debug.Log(string.Format("截屏了一张照片: {0}", filename));
      
    }


}
