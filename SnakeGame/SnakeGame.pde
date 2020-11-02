final int screenSize = 300;
int cubeSize = 20;
int arraySize = screenSize/cubeSize;
Cell[][] grid = new Cell[arraySize][arraySize];
PVector dir = new PVector(0, 1);
Snake snake;
Cell apple;
int delay = 100;


void settings(){
  size(screenSize, screenSize);

  

}

void setup(){
  initializeGrid();
  snake = new Snake(grid[0][8]);
  apple = choosesApple();
  changeCellTypes();
  displayGrid();

}

// bnasically every 'frame' of the game, update function
void draw(){
  if(!snake.snakeParts.contains(nextCell(snake.head))){
    snake.moveSnake();
  }
  else{
    crash(); 
  }
  
  if(checksApple()){snake.eatsApple();}
  changeCellTypes();
  displayGrid();
  delay(delay);
  
}

// stops the game 
void crash(){
  noLoop();
  println("Crashed");
  delay(2000);
  exit();
}

// Creates cell object for every element in grid[][]
void initializeGrid(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      grid[i][j] = new Cell(i, j);
    }
  }
}

// Draws a rectangle for each of the Cells in grid[][]
void displayGrid(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      grid[i][j].display();
    }
  }
}

// changes direction when key is pressed, accordingly
void keyPressed(){
  if(keyCode == UP & int(dir.y) != 1){dir.set(0, -1);}
  else if(keyCode == DOWN & int(dir.y) != -1){dir.set(0, 1);}
  else if(keyCode == LEFT & int(dir.x) != 1){dir.set(-1, 0);}
  else if(keyCode == RIGHT & int(dir.x) != -1){dir.set(1, 0);}
}

// Changes the cellTypes and color of every cell every cycle
void changeCellTypes(){
  for(int i = 0; i < arraySize; i++){
    for(int j = 0; j < arraySize; j++){
      
      if(snake.snakeParts.contains(grid[i][j])){
        grid[i][j].setCellType(1);
        grid[i][j].setColor(color(0,0,0));
      } 
      
      else if(grid[i][j] == apple){
        grid[i][j].setCellType(2);
        grid[i][j].setColor(color(255,0,0));
      }
      else{
        grid[i][j].setCellType(0);
        grid[i][j].setColor(color(255,255,255));
      }
      
    }
  }
}

// calculates what the next cell must be based on dx dy
Cell nextCell(Cell currentCell){
  int row = currentCell.row;
  int col = currentCell.col;
  Cell nextCell = new Cell(0, 0);
  row = row + int(dir.x);
  col = col + int(dir.y);
  if (col >= 0 & col < arraySize & row >= 0 & row < arraySize){
    nextCell = grid[col][row];  
  }
  
  else{
    crash();
  }
    
  
  return nextCell;
}

// returns a cell to assign as the new apple, after the snake has eaten it
Cell choosesApple(){
  int col, row;
  col = int(random(arraySize));
  row = int(random(arraySize));
  return grid[col][row];
}

// returns true if snake is on apple, false otherwise
boolean checksApple(){
  return(snake.head.col == apple.col & snake.head.row == apple.row);
  
}

class Snake{
  ArrayList<Cell> snakeParts = new ArrayList();
  Cell head;
  
  Snake(Cell initialHead){
    this.head = initialHead;
    snakeParts.add(initialHead);
  }
  
  void moveSnake(){
    snakeParts.add(0, nextCell(head));
    snakeParts.remove(snakeParts.size()-1);
    this.head = snakeParts.get(0);
  }
    
  void eatsApple(){
      snakeParts.add(snakeParts.size(), head);
      apple = choosesApple();
  }
  
  
}

class Cell{
  int col, row;
  color c = color(255,255,255);
  int cellType; // 0 = empty, 1 = snake, 2 = apple
  
  Cell(int col, int row){
    this.col = col;
    this.row = row;
  }
  
  int getCellType(){
    return cellType;
  }
  
  int getRow(){
    return this.row;
  }
  
  int getCol(){
    return this.col;
    
  }
  
  void setColor(color c){
      this.c = c;
  }
  
  void setRow(int row){
    this.row = row;
  }
  
  void setCol(int col){
    this.col = col;
  }
  
  void setCellType(int cellType){
    this.cellType = cellType;
  }
  
  void display(){
    fill(c);
    rect(row*cubeSize, col*cubeSize, cubeSize, cubeSize);
  }  
}
