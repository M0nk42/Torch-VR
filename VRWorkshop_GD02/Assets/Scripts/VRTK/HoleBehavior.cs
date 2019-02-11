using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK.Controllables;

public class HoleBehavior : MonoBehaviour {

    VRTK_BaseControllable controllable;

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

    void Start()
    {

    }


    // Update is called once per frame
    void Update()
    {

    }

    //Positive value
    private void OnValueChanged(object sender, ControllableEventArgs args)
    {
        Debug.Log("What is this ? = " + args.value);
    }
}
