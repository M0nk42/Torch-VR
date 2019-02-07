using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SouffletBehavior : MonoBehaviour {

    Collider windCollider;
    public GameObject OppositePanel;

	// Use this for initialization
	void Start () {
        windCollider = GetComponent<Collider>();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    private void OnCollisionEnter(Collision collision)
    {
        Debug.Log("This is a collider !" + collision);
    }
}
