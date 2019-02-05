using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//This singleton only applies to MonoBehaviour Tools
public class Singleton<T> : MonoBehaviour where T : MonoBehaviour
{

    private static bool _shuttingDown = false;
    private static object _lock = new object();
    private static T _instance;

    public static T Instance
    {
        get{
            if (_shuttingDown)
            {
                Debug.LogWarning("[Singleton] Instance: " + typeof(T) + "already destroyed. Returning null.");
                return null;
            }

            lock (_lock)
            {
                if(_instance == null)
                {
                    // Search for existing instance
                    _instance = (T)FindObjectOfType(typeof(T));

                    //Create new instance if one doesn't already exist.
                    if(Instance == null)
                    {
                        //Need to create a new GameObject to attach the singleton to.
                        GameObject singleObject = new GameObject();
                        _instance = singleObject.AddComponent<T>();
                        singleObject.name = typeof(T).ToString() + " (Singleton)";

                        //Make instance persistent
                        DontDestroyOnLoad(singleObject);
                    }
                }
                return _instance;
            }
        }
    }
     
    private void OnApplicationQuit()
    {
        _shuttingDown = true;
    }

    private void OnDestroy()
    {
        _shuttingDown = true;
    }
}
