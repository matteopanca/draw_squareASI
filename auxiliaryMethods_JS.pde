//VERSION for drawSI - 11/06/18
// h: 0 - v: 1
// o: 0 - l: 1 - r: 2 - u: 3 - d: 4

//initialize container variables
void defineContainers()
{
  numeroStrutture = 2*numeroLinee*(numeroLinee + 1);
  numeroVertici = numeroLinee*numeroLinee;
  centriX = new int[numeroStrutture];
  centriY = new int[numeroStrutture];
  isVertical = new boolean[numeroStrutture];
  tipoStruttura = new int[numeroStrutture];
  verticiX = new int[numeroVertici];
  verticiY = new int[numeroVertici];
  composizioneVertici = new int[numeroVertici][4];
  tipoVertice = new int[numeroVertici];
  tipoEsteso = new int[numeroVertici];
  
  //parametri delle strutture
  int baseDim = round(dimX/(3*(numeroLinee+1)));
  asseMaggiore = 2*baseDim;
  asseMinore = baseDim;
  firstLeftCoordX = round(1.5*baseDim);
  firstLeftCoordY = 3*baseDim;
  firstBottomCoordX = 3*baseDim;
  firstBottomCoordY = round(1.5*baseDim);
  stepX = 3*baseDim;
  stepY = 3*baseDim;
  
  rectMode(CENTER);
  noStroke();
  fill(structure);
  
  int counter, i, j, tempCentroX, tempCentroY, primoIndice, offset;
  
  //inizializzo il tipo di struttura per ogni dot
  struttureCatalogate = 0;
  for (i = 0; i<numeroStrutture; i++) tipoStruttura[i] = 0;
  
  counter = 0;
  //faccio cicli for per disegnare piu' linee
  //linee orizzontali
  for (i = 0; i<=(numeroLinee-1); i++)
    for (j = 0; j<=numeroLinee ; j++)
    {
      tempCentroX = RTP(firstLeftCoordX + stepX*j);
      tempCentroY = RTP(firstLeftCoordY + stepY*i);
      centriX[counter] = tempCentroX;
      centriY[counter] = tempCentroY;
      isVertical[counter] = false;
      rect(tempCentroX,tempCentroY,RTP(asseMaggiore),RTP(asseMinore),RTP(asseMinore)/2);
      counter++;
    }
  
  //linee verticali  
  for (i = 0; i<=(numeroLinee-1); i++)
    for (j = 0; j<=numeroLinee; j++)
    {
      tempCentroX = RTP(firstBottomCoordX + stepX*i);
      tempCentroY = RTP(firstBottomCoordY + stepY*j);
      centriX[counter] = tempCentroX;
      centriY[counter] = tempCentroY;
      isVertical[counter] = true;
      rect(tempCentroX,tempCentroY,RTP(asseMinore),RTP(asseMaggiore),RTP(asseMinore)/2);
      counter++;
    }
  
  //controllo prima le linee orizzontali e trovo le Y
  counter = 0;
  for (i = 0; i<numeroLinee; i++)
  {
    primoIndice = i*(numeroLinee + 1);
    for (j = 0; j<numeroLinee; j++)
    {
        verticiY[counter] = centriY[primoIndice+j];
        composizioneVertici[counter][0] = primoIndice+j;
        composizioneVertici[counter][1] = primoIndice+j+1;
        counter++;
    }
  }
  
  //controllo poi le linee verticali e trovo le X
  offset = numeroLinee*(numeroLinee + 1);
  for (i = 0; i<numeroLinee; i++)
  {
    primoIndice = i*(numeroLinee + 1) + offset;
    for (j = 0; j<numeroLinee; j++)
    {
        counter = j*numeroLinee + i;
        verticiX[counter] = centriX[primoIndice+j];
        composizioneVertici[counter][2] = primoIndice+j;
        composizioneVertici[counter][3] = primoIndice+j+1;
    }
  }
  
  /*for (i = 0; i<numeroVertici; i++)
  {
    print(i + ") ");
    for (j = 0; j<3; j++) print(composizioneVertici[i][j] + " - ");
    println(composizioneVertici[i][3]);
  }*/
}

//procedura di conversione "realToPixel"
int RTP(float input)
{
  int ris, shortPixels;
  float realUnit;
  
  if (dimX < dimY) realUnit = dimX;
  else realUnit = dimY;
  
  if (sizeX < sizeY) shortPixels = sizeX;
  else shortPixels = sizeY;
  
  ris = round((input/realUnit)*shortPixels);
  
  return ris;
}

//disegno la freccia
void drawArrow(int coordX, int coordY, int direzione)
{
  float percentualeMinore = 0.3;
  float percentualeMaggiore = 0.5;
  float percentualeTriangolo = 1;
  float percentualeShift = 0.125;
  int lunghezzaMinore = round(percentualeMinore*RTP(asseMinore));
  int lunghezzaMaggiore = round(percentualeMaggiore*RTP(asseMaggiore));
  int shift = round(percentualeShift*RTP(asseMaggiore));
  int[] coTr = new int[6];
  
  //lunghezzaMaggiore*1.05 for a good overlap...
  switch(direzione)
  {
    case 3: fill(arrowBody);
              rect(coordX,coordY+shift,lunghezzaMinore,lunghezzaMaggiore*1.05);
              fill(arrowPoint);
              coTr[0] = coordX - round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[1] = coordY - round(lunghezzaMaggiore/2) + shift;
              coTr[2] = coordX + round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[3] = coordY - round(lunghezzaMaggiore/2) + shift;
              coTr[4] = coordX;
              coTr[5] = coordY - round(lunghezzaMaggiore/2 + (percentualeTriangolo + 1)*lunghezzaMinore) + shift;
              triangle(coTr[0],coTr[1],coTr[2],coTr[3],coTr[4],coTr[5]);
              break;
              
    case 4: fill(arrowBody);
              rect(coordX,coordY-shift,lunghezzaMinore,lunghezzaMaggiore*1.05);
              fill(arrowPoint);
              coTr[0] = coordX - round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[1] = coordY + round(lunghezzaMaggiore/2) - shift;
              coTr[2] = coordX + round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[3] = coordY + round(lunghezzaMaggiore/2) - shift;
              coTr[4] = coordX;
              coTr[5] = coordY + round(lunghezzaMaggiore/2 + (percentualeTriangolo + 1)*lunghezzaMinore) - shift;
              triangle(coTr[0],coTr[1],coTr[2],coTr[3],coTr[4],coTr[5]);
              break;
              
    case 1: fill(arrowBody);
              rect(coordX+shift,coordY,lunghezzaMaggiore*1.05,lunghezzaMinore);
              fill(arrowPoint);
              coTr[0] = coordX - round(lunghezzaMaggiore/2) + shift;
              coTr[1] = coordY - round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[2] = coordX - round(lunghezzaMaggiore/2) + shift;
              coTr[3] = coordY + round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[4] = coordX - round(lunghezzaMaggiore/2 + (percentualeTriangolo + 1)*lunghezzaMinore) + shift;
              coTr[5] = coordY;
              triangle(coTr[0],coTr[1],coTr[2],coTr[3],coTr[4],coTr[5]);
              break;
              
    case 2: fill(arrowBody);
              rect(coordX-shift,coordY,lunghezzaMaggiore*1.05,lunghezzaMinore);
              fill(arrowPoint);
              coTr[0] = coordX + round(lunghezzaMaggiore/2) - shift;
              coTr[1] = coordY - round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[2] = coordX + round(lunghezzaMaggiore/2) - shift;
              coTr[3] = coordY + round((percentualeTriangolo + 1)*lunghezzaMinore/2);
              coTr[4] = coordX + round(lunghezzaMaggiore/2 + (percentualeTriangolo + 1)*lunghezzaMinore) - shift;
              coTr[5] = coordY;
              triangle(coTr[0],coTr[1],coTr[2],coTr[3],coTr[4],coTr[5]);
              break;
  
    default: break;
  }
  
}

void analizzaVertici(int tipoOutput)
{
  
  int i, somma, sommaIncompleti;
  
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
  textAlign(CENTER,CENTER);
  
  for (i = 0; i<numeroVertici; i++)
  {
    
    somma = 0;
    sommaIncompleti = 0;
    switch(tipoStruttura[composizioneVertici[i][0]])
    {
      case 1: somma += 0;
                break;
      case 2: somma += 8;
                break;
      case 0: sommaIncompleti += 1;
                break;
      default: break;
    }
    switch(tipoStruttura[composizioneVertici[i][2]])
    {
      case 3: somma += 0;
                break;
      case 4: somma += 4;
                break;
      case 0: sommaIncompleti += 1;
                break;
      default: break;
    }
    switch(tipoStruttura[composizioneVertici[i][1]])
    {
      case 1: somma += 2;
                break;
      case 2: somma += 0;
                break;
      case 0: sommaIncompleti += 1;
                break;
      default: break;
    }
    switch(tipoStruttura[composizioneVertici[i][3]])
    {
      case 3: somma += 1;
                break;
      case 4: somma += 0;
                break;
      case 0: sommaIncompleti += 1;
                break;
      default: break;
    }

    fill(universe);
    rect(verticiX[i],verticiY[i],round(0.9*RTP(asseMinore)),round(0.9*RTP(asseMinore)));
    if (sommaIncompleti == 0)
    {
      
      switch(somma)
      {
        case 0: tipoVertice[i] = 4;
                fill(T4);
                break;
        case 1: tipoVertice[i] = 3;
                fill(T3);
                break;
        case 2: tipoVertice[i] = 3;
                fill(T3);
                break;
        case 3: tipoVertice[i] = 2;
                fill(T2);
                break;
        case 4: tipoVertice[i] = 3;
                fill(T3);
                break;
        case 5: tipoVertice[i] = 1;
                fill(T1);
                break;
        case 6: tipoVertice[i] = 2;
                fill(T2);
                break;
        case 7: tipoVertice[i] = 3;
                fill(T3);
                break;
        case 8: tipoVertice[i] = 3;
                fill(T3);
                break;
        case 9: tipoVertice[i] = 2;
                fill(T2);
                break;
        case 10: tipoVertice[i] = 1;
                 fill(T1);
                 break;
        case 11: tipoVertice[i] = 3;
                 fill(T3);
                 break;
        case 12: tipoVertice[i] = 2;
                 fill(T2);
                 break;
        case 13: tipoVertice[i] = 3;
                 fill(T3);
                 break;
        case 14: tipoVertice[i] = 3;
                 fill(T3);
                 break;
        case 15: tipoVertice[i] = 4;
                 fill(T4);
                 break;
        default: break;              
      }
      tipoEsteso[i] = somma;
      
      switch(tipoOutput)
      {
        case 0: textSize(round(0.85*RTP(asseMinore)));
                text(tipoVertice[i],verticiX[i],verticiY[i]);
                break;
        case 1: textSize(round(0.7*RTP(asseMinore)));
                text(tipoEsteso[i],verticiX[i],verticiY[i]);
                break;
        case 2: ellipse(verticiX[i],verticiY[i],round(0.85*RTP(asseMinore)),round(0.85*RTP(asseMinore)));
                break;
        default: break; 
      }
      
    }
    
  }
  
}

void fillArray(int type)
{
  int i, counterHor = 0, horToCheck = 0, counterVer = 0, verToCheck = 0;
  int[] possHor = {2,1};
  int[] possVer = {3,4};
  
  pulisciArrows(structure);
  pulisciScritte();
  switch(type)
  {
    case 1: for (i = 0; i<numeroStrutture; i++)
            {
              if (isVertical[i]) 
              {
                tipoStruttura[i] = possVer[verToCheck%2];
                verToCheck++;
                counterVer++;
                if (((numeroLinee+1)%2 == 0) && (counterVer%(numeroLinee+1) == 0)) verToCheck++;
              }
              else
              {
                tipoStruttura[i] = possHor[horToCheck%2];
                horToCheck++;
                counterHor++;
                if (((numeroLinee+1)%2 == 0) && (counterHor%(numeroLinee+1) == 0)) horToCheck++;
              }
              drawArrow(centriX[i],centriY[i],tipoStruttura[i]);
            }
            break;
    case 2: for (i = 0; i<numeroStrutture; i++)
            {
              if (isVertical[i]) tipoStruttura[i] = 3;
              else tipoStruttura[i] = 2;
              drawArrow(centriX[i],centriY[i],tipoStruttura[i]);
            }
            break;
    case 3: for (i = 0; i<numeroStrutture; i++)
            {
              if (isVertical[i]) tipoStruttura[i] = 3;
              else tipoStruttura[i] = 1;
              drawArrow(centriX[i],centriY[i],tipoStruttura[i]);
            }
            break;
    default: break; 
  }
  struttureCatalogate = numeroStrutture;
}

void pulisciArrows(color colorToUse)
{
  int i;
  
  rectMode(CENTER);
  noStroke();
  fill(colorToUse);
  for (i = 0; i<numeroStrutture; i++)
  {
    tipoStruttura[i] = 0;
    if (isVertical[i]) rect(centriX[i],centriY[i],RTP(asseMinore),RTP(asseMaggiore),RTP(asseMinore)/2);
    else rect(centriX[i],centriY[i],RTP(asseMaggiore),RTP(asseMinore),RTP(asseMinore)/2);
  }
  struttureCatalogate = 0;
}

void pulisciScritte()
{
  
  int i;
  rectMode(CENTER);
  noStroke();
  fill(universe);
  for (i = 0; i<numeroVertici; i++) rect(verticiX[i],verticiY[i],round(0.9*RTP(asseMinore)),round(0.9*RTP(asseMinore)));
  
}
