using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{

	public Text sc;
	public Transform Player;
    public Transform End;
    float distance;
    // Update is called once per frame
    void Update()
    {
        distance = End.position.z - Player.position.z;
        sc.text = distance.ToString("0");
    }
}
