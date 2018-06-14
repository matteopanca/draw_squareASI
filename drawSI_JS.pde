//Processing 2
//VERSION 11/06/18
// h: 0 - v: 1
// o: 0 - l: 1 - r: 2 - u: 3 - d: 4

//numero delle linee
int numeroLinee = 5;
int numeroStrutture;
int numeroVertici;
int[] centriX;
int[] centriY;
boolean[] isVertical;
int[] tipoStruttura;
int[] verticiX;
int[] verticiY;
int[][] composizioneVertici;
int[] tipoVertice;
int[] tipoEsteso;

//parametri delle strutture
int asseMaggiore, asseMinore;
int firstLeftCoordX, firstLeftCoordY, firstBottomCoordX, firstBottomCoordY;
int stepX, stepY;

//dimensione della finestra in nm
float dimX = 1800, dimY = dimX;

//numero di pixels
int sizeX = 600, sizeY = 600;

//definizione colori varie strutture
color universe = color(160,160,160);
color structure = color(0,0,0);
color arrowBody = color(255,255,255); //color arrowBody = color(0,255,0);
color arrowPoint = color(255,255,255); //color arrowPoint = color(255,0,0);
color T1 = color(0,255,0);
color T2 = color(0,0,255);
color T3 = color(255,0,0);
color T4 = color(255,255,0);

//variabili ausiliarie
int struttureCatalogate;

//sequenza di generazione immagine
void setup()
{
  size(sizeX,sizeY);
  background(universe);
  
  defineContainers();
}

//questo non viene usato...
void draw()
{}

void mousePressed()
{
  int coordX = mouseX, coordY = mouseY;
  int centroXTrovato = 0, centroYTrovato = 0;
  int i, j, savedIndex = 0;
  boolean trovato = false, dotVerticale = false;
  char direzione;
  
  i = coordX + sizeX*coordY;
  loadPixels();
  if (pixels[i] != universe)
  {
    
    j = 0;
    while((!trovato) && (j < numeroStrutture))
    {
      if (abs(coordX - centriX[j]) < (RTP(asseMaggiore)/2.0))
      {
        centroXTrovato = centriX[j];
        if (abs(coordY - centriY[j]) < (RTP(asseMaggiore)/2.0))
        {
          centroYTrovato = centriY[j];
          dotVerticale = isVertical[j];
          savedIndex = j;
          trovato = true;
        }
      }
      j++;
    }
    
  }
  
  if (trovato)
  {
    
    //println("Sei sul dot a " + centroXTrovato + " - " + centroYTrovato);
    
    switch(mouseButton)
    {              
      case LEFT: switch(tipoStruttura[savedIndex])
                 {
                   case 0: if (dotVerticale) direzione = 3;
                             else direzione = 2;
                             drawArrow(centroXTrovato,centroYTrovato,direzione);
                             tipoStruttura[savedIndex] = direzione;
                             struttureCatalogate++;
                             break;
                             
                   case 1:
                   case 4: fill(structure);
                             if (dotVerticale)
                             {
                               rect(centroXTrovato,centroYTrovato,RTP(asseMinore),RTP(asseMaggiore),RTP(asseMinore)/2);
                               direzione = 3;
                             }
                             else
                             {
                               rect(centroXTrovato,centroYTrovato,RTP(asseMaggiore),RTP(asseMinore),RTP(asseMinore)/2);
                               direzione = 2;
                             }
                             drawArrow(centroXTrovato,centroYTrovato,direzione);
                             tipoStruttura[savedIndex] = direzione;
                             break;
                 }
                 break;
                 
      case RIGHT: switch(tipoStruttura[savedIndex])
                 {
                   case 0: if (dotVerticale) direzione = 4;
                             else direzione = 1;
                             drawArrow(centroXTrovato,centroYTrovato,direzione);
                             tipoStruttura[savedIndex] = direzione;
                             struttureCatalogate++;
                             break;
                             
                   case 2:
                   case 3: fill(structure);
                             if (dotVerticale)
                             {
                               rect(centroXTrovato,centroYTrovato,RTP(asseMinore),RTP(asseMaggiore),RTP(asseMinore)/2);
                               direzione = 4;
                             }
                             else
                             {
                               rect(centroXTrovato,centroYTrovato,RTP(asseMaggiore),RTP(asseMinore),RTP(asseMinore)/2);
                               direzione = 1;
                             }
                             drawArrow(centroXTrovato,centroYTrovato,direzione);
                             tipoStruttura[savedIndex] = direzione;
                             break;
                 }
                 break;
                   
      default: break;
    }
    analizzaVertici(2);
    //println("Strutture catalogate: " + struttureCatalogate + " (su " + numeroStrutture + ")");
    
  }
  
}

void keyPressed()
{
  int codice = keyCode;
  //println("Key Code: " + codice);
  
  switch(codice)
  {
    case 49:
    case 50:
    case 51:
    case 52:
    case 53:
    case 54:
    case 55:
    case 56:
    case 57: background(universe);
             numeroLinee = codice - 48;
             defineContainers();
             break;
    case 88: fillArray(1);
             analizzaVertici(2);
             break;
    case 89: fillArray(2);
             analizzaVertici(2);
             break;
    case 90: fillArray(3);
             analizzaVertici(2);
             break;
    case 67: analizzaVertici(0);
             break;
    case 69: analizzaVertici(1);
             break;
    case 68: analizzaVertici(2);
             break;
    case 79: pulisciArrows(structure);
             pulisciScritte();
             break;
    case 80: pulisciScritte();
             break;
    case 83: String outputName = "ASI_" + year() + month() + day() + "_" + hour() + minute() + second() + ".png";
             saveFrame(outputName);
             break;
    default: break;
  }
  
}
