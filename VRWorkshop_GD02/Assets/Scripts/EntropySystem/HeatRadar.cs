﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatRadar : MonoBehaviour {

    SphereCollider WarmZone;
    float radius;

    //LayerMask
    LayerMask coldLayer;
    public string coldLayerName = "ColdObject";

    LayerMask flareLayer;
    public string flareLayerName = "Flare";
    public float intensity = 1;

    //Get all the objects in range.
    List<GameObject> ColdObjects;

    // Use this for initialization
    void Start () {
        WarmZone = GetComponent<SphereCollider>();
        radius = WarmZone.radius;

        coldLayer = LayerMask.NameToLayer(coldLayerName);
        flareLayer = LayerMask.NameToLayer(flareLayerName);

        ColdObjects = new List<GameObject>();
	}
	
	// Update is called once per frame
	void Update () {

        foreach (var coldObject in ColdObjects)
        {
            float distance = Vector3.Distance(coldObject.transform.position, transform.position);
            //Debug.Log(distance);
        }
	}

    public void Kill()
    {
        foreach (var coldObject in ColdObjects)
        {
            coldObject.GetComponent<EntropyEntity>().HeatRadars.Remove(gameObject);
        }
        Destroy(gameObject);
    }

    public void AddPower()
    {
        radius =+ 1;
        intensity = +1;
    }

    public void RemovePower()
    {
        radius =- 1;
        intensity = -1;
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other.gameObject.layer);

        //Melt frozen object
        if (other.gameObject.layer == coldLayer.value)
        {
            Debug.Log(other.gameObject);
            
            //Test if the gameObject HAS the HeatWave Behavior
            if (other.gameObject.GetComponent<EntropyEntity>())
            {
                Debug.Log("ENTERING: Is Cold Object Layered");
                //Add to list
                ColdObjects.Add(other.gameObject);

                //Increment warmth
                EntropyEntity coldObject = other.gameObject.GetComponent<EntropyEntity>();
                coldObject.HeatRadars.Add(gameObject);
            }
        }

        //Light Up flare

        if (other.gameObject.layer == flareLayer.value)
        {
            Debug.Log(other.gameObject);

            //Test if the gameObject HAS the HeatWave Behavior
            if (other.gameObject.GetComponent<FlareBehaviour>())
            {
                Debug.Log("ENTERING: Is Flare");

                //Increment warmth
                FlareBehaviour flare = other.gameObject.GetComponent<FlareBehaviour>();
                flare.LightFlare();

            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.layer == coldLayer.value)
        {

            Debug.Log(other.gameObject);
            
            //Test if the gameObject HAS the HeatWave Behavior
            if (other.gameObject.GetComponent<EntropyEntity>())
            {
                Debug.Log("EXITING: Is Cold Object Layered");
                ColdObjects.Remove(other.gameObject);

                //Decrement Warmth
                EntropyEntity coldObject = other.gameObject.GetComponent<EntropyEntity>();
                coldObject.HeatRadars.Remove(gameObject);
            }
        }
    }
}
