using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookWalk : MonoBehaviour
{
    public Transform vrCamera;
    public float toggleAngle = 30.0f;
	public float speed = 8.0f;
	public float gravity = 10f;
    public bool moveForward;
	public CharacterController controller;
    void Start()
    {
        controller = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
        //PlayerMovement();
        if (vrCamera.eulerAngles.x >= toggleAngle && vrCamera.eulerAngles.x <= 90.0f){
            moveForward = true;
        }
        else{
            moveForward = false;
        }
        if (moveForward){
            Vector3 forward = vrCamera.TransformDirection(Vector3.forward);
            controller.SimpleMove(forward * speed);
        }

    }

}
