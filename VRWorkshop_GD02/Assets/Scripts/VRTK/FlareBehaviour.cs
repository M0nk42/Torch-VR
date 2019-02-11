using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlareBehaviour : MonoBehaviour {

    float lifespan = 0;
    public float maxLifespan;
    Light light;
    public GameObject Parent;

    bool lighted = false;

    private void Start()
    {
        light = GetComponent<Light>();
    }

    private void Update()
    {
        if (lighted)
        {
            lifespan += Time.deltaTime;
        }

        if (lifespan > maxLifespan)
        {
            KillFlare();
        }
    }

    public void LightFlare()
    {
        light.enabled = true;
        lighted = true;
        lifespan = 0;
    }

    public void ExtinguishFlare()
    {
        light.enabled = false;
    }

    public void KillFlare()
    {
        ExtinguishFlare();
        Destroy(Parent);
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other);

        if (other.gameObject.layer == LayerMask.NameToLayer("LightFlare"))
        {
            LightFlare();
        }
    }
}
