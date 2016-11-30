using UnityEngine;
using System.Collections;
using LuaInterface;
public class TriggerScript : MonoBehaviour
{

    public LuaFunction LuaOnTriggerEnter;

    public LuaFunction LuaOnTriggerExit;

    public LuaFunction LuaOnTriggerStay;

    void OnTriggerEnter2D(Collider2D col)
    {
        if (LuaOnTriggerEnter != null)
            LuaOnTriggerEnter.Call(col);
    }
    void OnTriggerExit2D(Collider2D col)
    {
        if(LuaOnTriggerExit != null)
            LuaOnTriggerExit.Call(col);
    }
    void OnTriggerStay2D(Collider2D col)
    {
        if (LuaOnTriggerStay != null)
            LuaOnTriggerStay.Call(col);
    }
}
