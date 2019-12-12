using UnityEngine;

public class ObstacleScale : MonoBehaviour
{
    public bool IsScaleX = false;
    public bool IsScaleY = false;
    public bool IsScaleZ = false;

    public Vector3 xoffset;
    public Vector3 yoffset;
    public Vector3 zoffset;

    public bool IsXAscending = true;
    public bool IsYAscending = true;
    public bool IsZAscending = true;

    public float Xmaxima = 5f;
    public float Xminima = 1f;

    public float Ymaxima = 5f;
    public float Yminima = 1f;

    public float Zmaxima = 3f;
    public float Zminima = 1f;

    // Update is called once per frame
    void Update()
    {
        if (IsScaleX == true)
        {
            if (IsXAscending == true)
            {
                transform.localScale += xoffset;
                if(transform.localScale.x >= Xmaxima)
                {
                    IsXAscending = false;
                }
            }

            else if (IsXAscending == false)
            {
                transform.localScale = transform.localScale - xoffset;
                if (transform.localScale.x <= Xminima)
                {
                    IsXAscending = true;
                }
            }
        }
        if (IsScaleY == true)
        {
            if (IsYAscending == true)
            {
                transform.localScale += yoffset;
                if (transform.localScale.y >= Ymaxima)
                {
                    IsYAscending = false;
                }
            }

            else if (IsYAscending == false)
            {
                transform.localScale = transform.localScale - yoffset;
                if (transform.localScale.y <= Yminima)
                {
                    IsYAscending = true;
                }
            }
        }
        if (IsScaleZ == true)
        {
            if (IsZAscending == true)
            {
                transform.localScale += zoffset;
                if (transform.localScale.z >= Zmaxima)
                {
                    IsZAscending = false;
                }
            }

            else if (IsZAscending == false)
            {
                transform.localScale = transform.localScale - zoffset;
                if (transform.localScale.z <= Zminima)
                {
                    IsZAscending = true;
                }
            }
        }
        

    }
}
