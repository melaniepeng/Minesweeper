import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    //your code to declare and initialize buttons goes here
    bombs = new ArrayList <MSButton>();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    setBombs();
}
public void setBombs()
{
    //your code
    for (int b = 0; b < 50; b++)
    {
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        if (!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);
        }
    }
}

public void draw ()
{
    background( 0 );

    if(isWon())
    displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    System.out.print("LOSER!!!");
    text("YOU LOSE!!!",200,150);

}
public void displayWinningMessage()
{
    //your code here
    System.out.print("YOU WIN!!!");
    text("YOU WIN!!!",200,150);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (keyPressed == true)
        {
            marked = false;
        }
        if(bombs.contains(buttons[r][c]))
        {
            displayLosingMessage();
        }
        else if (countBombs(r,c) > 0)
        {
            setLabel(" "+ countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && buttons[r][c-1].isClicked() == false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && buttons[r][c+1].isClicked() == false)
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && buttons[r-1][c].isClicked() == false)
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r+1,c) && buttons[r+1][c].isClicked() == false)
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked() == false)
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked() == false)
            {
                buttons[r-1][c+1].mousePressed();
            }            
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked() == false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked() == false)
            {
                buttons[r+1][c+1].mousePressed();
            }
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(mouseButton == RIGHT)
        {
            clicked = false;
            fill(0);
        }
        else  if (clicked && bombs.contains(this) ) 
        {
            fill(255,0,0);
        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        textSize(15);
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if ( r >= 0 && r < NUM_ROWS && c >=0 && c < NUM_COLS)
        {
            return true;
        }
        else
        {
            return false;
        }
        
    }
    public int countBombs(int row, int col)
    {

        int numBombs = 0;
        //your code here
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs = numBombs +1;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs = numBombs +1;
        }
        //System.out.println("CountBombs " + numBombs);
        return numBombs;  
    }
}
