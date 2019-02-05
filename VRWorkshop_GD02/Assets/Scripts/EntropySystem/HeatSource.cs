using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class HeatSource : MonoBehaviour {

    public int numHeatWaves = 5;

    [Tooltip("The lower the number, the more accurate it is")]
    public float heatPrecision = 0.5f;
    float maxHeatRadius = 0;
    GameObject heatWavePref;

    List<GameObject> HeatWaves;

    //Game Manager
    GameManager GM;

    private void Start()
    {
        InitializeHS();
    }

    private void Update()
    {
        SetGlobalAttributs();
    }

    private void InitializeHS()
    {
        GM = GameManager.Instance;

        SetGlobalAttributs();

        HeatWaves = new List<GameObject>();
        heatWavePref = Resources.Load<GameObject>("Prefabs/HeatWave");

        //Add as many HeatSource as necessary
        for (int i = 0; i < numHeatWaves; i++)
        {
            AddHeatWave();
        }
    }

    private void SetGlobalAttributs()
    {
        heatPrecision = GM._warmAttributs.HeatPrecision;
    }

    public void AddHeatWave()
    {
        maxHeatRadius += heatPrecision;

        //Instantiate the heatwave as child of heat source
        var heatObject = Instantiate(heatWavePref,transform);

        //Set the heat wave attributes
        var heatWave = heatObject.GetComponent<HeatWave>();
        heatWave.radius = maxHeatRadius;

        //Add the HeatObject to List
        HeatWaves.Add(heatObject);
        
    }

    public void RemoveHeatWave()
    {
        if (HeatWaves.Count <= 0)
        {
            Debug.LogWarning("There is no more HeatWaves to extinguish");
            return;
        }

        maxHeatRadius -= heatPrecision;
        var lastHeatWave = HeatWaves[HeatWaves.Count-1];
        HeatWaves.Remove(lastHeatWave);
        lastHeatWave.GetComponent<HeatWave>().Kill();
    }


}
