using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeatWave : MonoBehaviour {

    SphereCollider WarmZone;
    public float radius = 0.5f;

    //LayerMask
    LayerMask coldLayer;
    public string coldLayerName = "ColdObject";

    //Get all the objects in range.
    List<GameObject> ColdObjects;

    // Use this for initialization
    void Start () {
        WarmZone = GetComponent<SphereCollider>();
        WarmZone.radius = radius;

        coldLayer = LayerMask.NameToLayer(coldLayerName);

        ColdObjects = new List<GameObject>();
	}
	
	// Update is called once per frame
	void Update () {
	}

    public void Kill()
    {
        foreach (var coldObject in ColdObjects)
        {
            //coldObject.GetComponent<EntropyEntity>().DecrementCounter();
        }
        Destroy(gameObject);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == coldLayer.value)
        {
            Debug.Log(other.gameObject);
            Debug.Log("ENTERING: Is Cold Object Layered");
            //Test if the gameObject HAS the HeatWave Behavior
            if (other.gameObject.GetComponent<EntropyEntity>())
            {
                //Add to list
                ColdObjects.Add(other.gameObject);

                //Increment warmth
                EntropyEntity coldObject = other.gameObject.GetComponent<EntropyEntity>();
                //coldObject.IncrementCounter();
            }
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log(collision.gameObject);
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.layer == coldLayer.value)
        {
            Debug.Log("EXITING: Is Cold Object Layered");
            //Test if the gameObject HAS the HeatWave Behavior
            if (other.gameObject.GetComponent<EntropyEntity>())
            {

                ColdObjects.Remove(other.gameObject);

                //Decrement Warmth
                EntropyEntity coldObject = other.gameObject.GetComponent<EntropyEntity>();
                //coldObject.DecrementCounter();
            }
        }
    }
}
