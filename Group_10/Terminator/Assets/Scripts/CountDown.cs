using UnityEngine;
using UnityEngine.UI;

public class CountDown : MonoBehaviour
{
    public Movement movement;
    public Text uiTime;
    public float mainTimer;

    private float timer;
    private bool canCount = true;
    private bool doOnce = false;

    // Start is called before the first frame update
    void Start()
    {
        timer = mainTimer;    
    }

    // Update is called once per frame
    void Update()
    {
        if (timer >= 0.0f && canCount)
        {
            timer -= Time.deltaTime;
            uiTime.text = timer.ToString("F");
        }
        else if(timer <= 0.0f && !doOnce)
        {
            movement.enabled = false;
            canCount = false;
            doOnce = true;
            uiTime.text = "0.00";
            timer = 0.0f;
            FindObjectOfType<GameManager>().EndGame();
        }
    }
}
