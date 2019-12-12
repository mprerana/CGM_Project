using UnityEngine;

public class ObstacleRotate : MonoBehaviour
{
    public bool IsRotateX = false;
    public bool IsRotateY = false;
    public bool IsRotateZ = false;
    // Update is called once per frame
    void Update()
    {   
        if (IsRotateX == true)
        {
            transform.Rotate(new Vector3(1f, 0f, 0f));
        }
        if (IsRotateY == true)
        {
            transform.Rotate(new Vector3(0f, 1f, 0f));
        }
        if (IsRotateZ == true)
        {
            transform.Rotate(new Vector3(0f, 0f, 1f));
        }

    }
}
