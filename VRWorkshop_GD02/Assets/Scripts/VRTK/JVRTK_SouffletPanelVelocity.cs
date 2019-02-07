using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class JVRTK_SouffletPanelVelocity : MonoBehaviour {


    VRTK_VelocityEstimator velEstimator;
	// Use this for initialization
	void Start () {
        velEstimator = GetComponent<VRTK_VelocityEstimator>();
        velEstimator.StartEstimation();
    }
	
	// Update is called once per frame
	void Update () {
        Debug.Log("Acceleration" + velEstimator.GetAccelerationEstimate());

        Debug.Log("Angular Velocity" + velEstimator.GetAngularVelocityEstimate());

        Debug.Log("Angular Acceleration" + velEstimator.GetVelocityEstimate());
    }
}
