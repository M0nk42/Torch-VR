using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;
using VRTK.Controllables;
using VRTK.Controllables.ArtificialBased;

public class SouffletBehavior : MonoBehaviour {

    VRTK_BaseControllable controllable;
    bool windUp = false;

    public GameObject Poellon;
    PoellonBehavior poellonBehavior;

    void OnEnable()
    {
        controllable = (controllable == null ? GetComponent<VRTK_BaseControllable>() : controllable);
        controllable.ValueChanged -= OnValueChanged;
        controllable.ValueChanged += OnValueChanged;
    }

    void OnDisable()
    {
        controllable.ValueChanged -= OnValueChanged;

    }

    void Start () {

        poellonBehavior = Poellon.GetComponent<PoellonBehavior>();

	}


    // Update is called once per frame
    void Update () {

    }

    //Positive value
    private void OnValueChanged(object sender, ControllableEventArgs args)
    {
        float value = args.normalizedValue;

        if (value > 0.8f)
        {
            windUp = true;
        }

        if (windUp && value < 0.15)
        {
            windUp = false;

            poellonBehavior.AddPower();
            
        }
    }
}
