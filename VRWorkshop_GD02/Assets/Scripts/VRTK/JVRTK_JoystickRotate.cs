using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using VRTK;

public class JVRTK_JoystickRotate : MonoBehaviour {

    public VRTK_ControllerEvents controllerEvents;

    [Tooltip("The button used to use/unuse a touched Interactable Object.")]
    public VRTK_ControllerEvents.ButtonAlias useButton = VRTK_ControllerEvents.ButtonAlias.TriggerTouch;

    /// <summary>
    /// Emitted when the use toggle alias button is pressed.
    /// </summary>
    public event ControllerInteractionEventHandler UseButtonPressed;

    [Tooltip("The Interact Touch to listen for touches on. If the script is being applied onto a controller then this parameter can be left blank as it will be auto populated by the controller the script is on at runtime.")]
    public VRTK_InteractTouch interactTouch;

    protected VRTK_ControllerEvents.ButtonAlias subscribedUseButton = VRTK_ControllerEvents.ButtonAlias.Undefined;
    protected VRTK_ControllerEvents.ButtonAlias savedUseButton = VRTK_ControllerEvents.ButtonAlias.Undefined;
    protected bool usePressed;
    protected VRTK_ControllerReference controllerReference
    {
        get
        {
            return VRTK_ControllerReference.GetControllerReference((interactTouch != null ? interactTouch.gameObject : null));
        }
    }

    protected virtual void OnEnable()
    {
        controllerEvents = (controllerEvents != null ? controllerEvents : GetComponent<VRTK_ControllerEvents>());

        ManageUseListener(true);
    }

    private void Update()
    {
        //Debug.Log(controllerEvents.GetAxis(VRTK_ControllerEvents.Vector2AxisAlias.Touchpad));
    }

    protected virtual void OnDisable()
    {
        ManageUseListener(false);
    }

    private void OnDestroy()
    {
        controllerEvents = null;
    }

    private void ManageUseListener(bool state)
    {
        
        if (controllerEvents != null && subscribedUseButton != VRTK_ControllerEvents.ButtonAlias.Undefined && (!state || useButton != subscribedUseButton))
        {
            controllerEvents.UnsubscribeToButtonAliasEvent(subscribedUseButton, true, StartDoTurn);
            subscribedUseButton = VRTK_ControllerEvents.ButtonAlias.Undefined;
        }

        if (controllerEvents != null && state && useButton != VRTK_ControllerEvents.ButtonAlias.Undefined && useButton != subscribedUseButton)
        {
            controllerEvents.SubscribeToButtonAliasEvent(useButton, true, StartDoTurn);
            subscribedUseButton = useButton;
        }
    }

    public virtual void OnUseButtonPressed(ControllerInteractionEventArgs e)
    {
        if (UseButtonPressed != null)
        {
            UseButtonPressed(this, e);
        }
    }

    protected virtual void StartDoTurn(object sender, ControllerInteractionEventArgs e)
    {
        OnUseButtonPressed(controllerEvents.SetControllerEvent(ref usePressed, true));
        Debug.Log(e);
        //AttemptDoTurn(sender);
    }

    protected virtual void AttemptDoTurn()
    {
        Debug.Log("Pressed");
    }
}
