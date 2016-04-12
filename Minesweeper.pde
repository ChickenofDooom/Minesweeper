import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS=20;
private final static int NUM_COLS=20;
private final static int NUM_BOMBS=50;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  bombs=new ArrayList <MSButton>();
  buttons=new MSButton[NUM_ROWS][NUM_COLS];
  //your code to declare and initialize buttons goes here
  for (int rows=0; rows<NUM_ROWS; rows++) {
    for (int cols=0; cols<NUM_COLS; cols++) {
      buttons[rows][cols]=new MSButton(rows, cols); 

      //setBombs();
    }
  }
  setBombs();
}
public void setBombs()
{
  for (int i=0; i<NUM_BOMBS; i++)
  {
    int r= (int)(Math.random()*NUM_ROWS);
    int c= (int)(Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[r][c]))
    {
      bombs.add(buttons[r][c]);
    }
  }    //your code
  /* while (bombs.size()<NUM_BOMBS)
   {
   int r= (int)(Math.random()*NUM_ROWS);
   int c= (int)(Math.random()*NUM_COLS);
   if (!bombs.contains(buttons[r][c]))
   {
   bombs.add(buttons[r][c]);
   }
   }*/
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
  return false;

}
public void displayLosingMessage()
{
  //your code here
  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked())
      {
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
      }
    }
  }
  /*
  for (int i=0; i<NUM_ROWS; i++)
   {
   for (int x=0; x<NUM_COLS; x++)
   {
   buttons[x][i].label="";
   }
   }
   */
  buttons[9][9].label="y";
  buttons[9][10].label="o";
  buttons[9][11].label="u";
  buttons[9][12].label="";
  buttons[10][8].label="l";
  buttons[10][9].label="o";
  buttons[10][10].label="s";
  buttons[10][11].label="e";
  buttons[10][12].label="!";

}
public void displayWinningMessage()
{
  //your code here
  buttons[9][9].label="y";
  buttons[9][10].label="o";
  buttons[9][11].label="u";
  buttons[9][12].label="";
  buttons[10][8].label="w";
  buttons[10][9].label="o";
  buttons[10][10].label="n";
  buttons[10][11].label="!";
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
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
    /* clicked = true;
     if(marked==true){
     marked = false;
     if(isValid(r,c-1) && buttons[r][c-1].isMarked())
     buttons[r][c-1].mousePressed();
     
     if(isValid(r,c+1) && buttons[r][c+1].isMarked())
     buttons[r][c+1].mousePressed();
     
     
     if(isValid(r-1,c) && buttons[r-1][c].isMarked())
     buttons[r-1][c].mousePressed();
     
     if(isValid(r+1,c) && buttons[r+1][c].isMarked())
     buttons[r+1][c].mousePressed();
     
     //your code here
     }*/
    if (mouseButton==RIGHT)
    {
      marked=!marked;
    } 
    if (mouseButton==LEFT&&!marked)
    {
      clicked=true;
    }
    if (bombs.contains(this))
    {
      displayLosingMessage();
    } else if (countBombs(r, c)>0)
    {
      label="" + countBombs(r, c);
    } else 
    {
      if (isValid(r, c-1)==true && buttons[r][c-1].isClicked()==false)
      {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1)==true && buttons[r][c+1].isClicked()==false)
      {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c)==true && buttons[r-1][c].isClicked()==false)
      {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r+1, c)==true && buttons[r+1][c].isClicked()==false)
      {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c+1)==true && buttons[r-1][c+1].isClicked()==false)
      {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c+1)==true && buttons[r+1][c+1].isClicked()==false)
      {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r-1, c-1)==true && buttons[r-1][c-1].isClicked()==false)
      {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r+1, c-1)==true && buttons[r+1][c-1].isClicked()==false)
      {
        buttons[r+1][c-1].mousePressed();
      }
    }
  }
  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    return r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS;
    // return false;
  }
  public int countBombs(int row, int col)
  {
    //int numBombs = 0;
    //your code here
    //  return numBombs;
    int numBombs = 0;
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
    {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
    {
      numBombs++;
    }
    if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
    {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
    {
      numBombs++;
    }
    if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
    {
      numBombs++;
    }
    if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
    {
      numBombs++;
    }
    return numBombs;
  }
}
