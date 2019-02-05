using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public enum TemperatureState
{
    Burning,
    Hot,
    Warm,
    Neutral,
    Cold,
    Freezing
}

public class EntropyEntity : MonoBehaviour {

    public float currentHeat = 200;
    public float entropyFactor = 1;

    float entropyPoint = 0;
    float heatingValue;// The value that increments the heat

    //Material
    Renderer renderer;

    [HideInInspector]
    public TemperatureState TempState;

    float globalWarmFactor = 5;

    [HideInInspector]
    public float globalFreezeFactor = 20;

    float t = 0;
    public float ticks = 1;

    delegate bool MyTicker();
    MyTicker myTicker;

    //GameManager Singleton
    GameManager GM;


    //HeatWaves
    [HideInInspector]
    public List<GameObject> HeatRadars;

    //HeatLayer
    public string heatLayerName = "HeatLayer";
    LayerMask heatLayer;

    //Some fuckery to fixed Unity bad behaviors ...
    bool isColliding;

	// Use this for initialization
	void Start () {
        //Initialise singleton Game Manager for global reach and set up variables
        Initialize();

        //Need this maybe later
        HeatRadars = new List<GameObject>();

        //Setting the layer heat
        heatLayer = LayerMask.NameToLayer(heatLayerName);
        //Add some margin for the tick, roughly higher than one second
        ticks += 0.1f;
        //Delegates the tick for reuse ... perhaps, or maybe I don't understand the delegate ...
        myTicker = Tick;

        //Get the current material for shader stuff purposes
        renderer = GetComponent<Renderer>();
    }
	
	// Update is called once per frame
	void Update () {
        heatingValue = 0;
        SetGlobalAttributes();

        foreach (var heatRadar in HeatRadars)
        {
            heatingValue += GetHeatFromHR(heatRadar);
        }
        
        entropyPoint = GetEntropyPoint(entropyFactor);
        //Debug.Log(entropyPoint);

        if (myTicker())
        {
            if (currentHeat > entropyPoint + (heatingValue/10))
            {
                freezing();
            }
            if (currentHeat < entropyPoint)
            {
                warming();
            }
        }
        //Debug.Log(heatingValue);
        //Debug.Log(currentHeat);
        setTempState();
        //Debug.Log(heatWavesCounter);
        isColliding = false;

        //Shader Change
        float iceShader = 1 - (currentHeat / 100);

        //Unfrozen
        if (currentHeat > 100)
        {
            iceShader = 0;
        }

        //Frozen
        if (currentHeat < 0)
        {
            iceShader = 1;
        }
        renderer.material.SetFloat("_ice", iceShader);

        Debug.Log("IceShader : " + iceShader);
    }

    private void Initialize()
    {
        GM = GameManager.Instance;
        SetGlobalAttributes();
    }

    private void SetGlobalAttributes()
    {
        globalWarmFactor = GM._warmAttributs.HeatFactor;
        globalFreezeFactor = GM._coldAttributs.FreezeFactor;
    }

    bool Tick()
    {
        bool value;
        t += Time.deltaTime;

        if (t >= ticks)
        {
            value = true;
        }
        else
        {
            value = false;
        }

        t = t % ticks;
        return value;
    }

    //TODO determine a smarter cold and warm value ...
    //TODO Freeze coefficient, maybe ...
    void freezing()
    {
        currentHeat -= globalFreezeFactor*2;
    }
    public void SetWarmFactor(float value)
    {
        globalWarmFactor = value;
    }
    //TODO Warm coefficient, maybe ...
    public void warming()
    {
        currentHeat += heatingValue / 10;
        
    }

    public void setTempState()
    {
        if (currentHeat >= 1000)
        {
            TempState = TemperatureState.Burning;
        }

        if(currentHeat < 1000 && currentHeat >= 600)
        {
            TempState = TemperatureState.Hot;
        }

        if (currentHeat < 600 && currentHeat >= 200)
        {
            TempState = TemperatureState.Warm;
        }

        if (currentHeat < 200 && currentHeat >= -200)
        {
            TempState = TemperatureState.Neutral;
        }

        if (currentHeat < -200 && currentHeat >= -600)
        {
            TempState = TemperatureState.Cold;
        }

        if (currentHeat < -600 && currentHeat >= -1000)
        {
            TempState = TemperatureState.Freezing;
        }
    }

    #region EntropyPoint
    public float GetEntropyPoint(float EntropyFactor = 50)
    {
        float result = (heatingValue - globalFreezeFactor) * EntropyFactor;

        return result;
    }

    //Return the heat from one single heat source
    float GetHeatFromHR(GameObject heatRadar)
    {
        HeatRadar heatRadarSc = heatRadar.GetComponent<HeatRadar>();
        float heatRange = heatRadar.GetComponent<SphereCollider>().radius;
        float intensity = heatRadarSc.intensity;
        float distance = Vector3.Distance(heatRadar.transform.position, transform.position);
        if (distance <= 0.1f)
            distance = 0.1f;
        float heat = (1 / distance) * globalWarmFactor * heatRange * intensity; // warmFactor is a global

        return heat;
    }
    #endregion
}
