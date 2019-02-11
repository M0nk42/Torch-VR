using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PoellonBehavior : MonoBehaviour {
    SphereCollider WarmZone;
    int intensity;

    LayerMask layerMask;
    string torchString = "TorchLayer";

    public int maxIntensity = 5;

    public Material onFire;
    Renderer renderer;

    // Use this for initialization
    void Start()
    {
        WarmZone = GetComponent<SphereCollider>();
        intensity = 0;

        renderer = GetComponent<Renderer>();

        layerMask = LayerMask.NameToLayer(torchString);
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void AddPower()
    {
        if (intensity >= maxIntensity)
        {
            return;
        }
        WarmZone.radius =+ 1;
        intensity++;

        if (intensity >= maxIntensity)
        {
            renderer.material = onFire;
        }
    }

    public void RemovePower()
    {
        if (intensity <= maxIntensity)
        {
            return;
        }

        WarmZone.radius =- 1;
        intensity--;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == layerMask.value)
        {
            Debug.Log("TouchTorch");
            if (intensity >= 5)
            {
                other.gameObject.GetComponentInChildren<ParticleSystem>().Play();
            }

        }
    }

    private void OnTriggerExit(Collider other)
    {

    }
}
