using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class HoleBoxBehavior : MonoBehaviour {

    public int MaxHole = 4;
    int currentHoleFilled = 0;

    public UnityEvent OpenEvent;
    public UnityEvent CloseEvent;

    bool trigerBool = true;

    private void Start()
    {
        currentHoleFilled = 0;
    }

    private void Update()
    {
        //Open
        if(currentHoleFilled >= MaxHole)
        {
            if (trigerBool)
            {
                trigerBool = false;
                Debug.Log("Open");
                OpenEvent.Invoke();
            }
            
        }

        //Close
        if (currentHoleFilled < MaxHole)
        {
            if (!trigerBool)
            {
                trigerBool = true;
                Debug.Log("Close");
                CloseEvent.Invoke();
            }

        }
    }

    public void HoleFill()
    {
        currentHoleFilled++;
    }

    public void HoleEmpty()
    {
        currentHoleFilled--;
    }


    //Open the scene
    public void Open()
    {
        
    }


    //Open the scene
    public void Close()
    {
        
    }
}
