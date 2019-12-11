using UnityEngine;

public class Movement : MonoBehaviour
{
	public Rigidbody rb;
    
    public float ForwardForce = 2000f;
    public float BackwardForce = 2000f;
    public float SideForce = 2000f;

    // Update is called once per frame
    void FixedUpdate()
    {
        
        if(Input.GetKey(KeyCode.UpArrow)){
        	rb.AddForce(0,0,ForwardForce * Time.deltaTime);	
        }
        if (Input.GetKey(KeyCode.RightArrow)){
        	rb.AddForce(SideForce * Time.deltaTime,0,0, ForceMode.VelocityChange);	
        }
        if(Input.GetKey(KeyCode.LeftArrow)){
        	rb.AddForce(-SideForce * Time.deltaTime,0,0, ForceMode.VelocityChange);	
        }
        if(Input.GetKey(KeyCode.DownArrow)){
        	rb.AddForce(0,0,-BackwardForce * Time.deltaTime);	
        }

        if(rb.position.y < -3f){
            FindObjectOfType<GameManager>().EndGame();
        }
    }
}
