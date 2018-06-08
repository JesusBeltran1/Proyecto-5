int angulo = 0;
int tamanio_de_la_serpiente = 2;
int tiempo = 0;
int[] x= new int[2500];
int[] y= new int[2500];
int manzana_x = (round(random(160))+1)*8;
int manzana_y = (round(random(60))+1)*8;
boolean reposicionar_manzana = true;
boolean fin_del_juego = false;
void setup()
{
  reiniciar();
  size(1360, 700);
  textAlign(CENTER);
}
void draw()
{
  if (fin_del_juego)
  {
    
  }
  else
  {
  tiempo+=1;
  frameRate(70);
  fill(random(255), random(255), random(255));
  stroke(0);
  rect(manzana_x,manzana_y,8,8);
  fill(random(255), random(255), random(255));
  noStroke();
  rect(0,0,width,8);
  rect(0,height-8,width,8);
  rect(0,0,8,height);
  rect(width-8,0,8,height);
 
  if ((tiempo % 2)==0)
  {
    trayecto();
    display();
    muerte();
  }
  }
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP && angulo!=270 && (y[1]-8)!=y[2])
    {
      angulo=90;
    }
    
    if (keyCode == DOWN && angulo!=90 && (y[1]+8)!=y[2])
    {
      angulo=270;
    }
    
    if (keyCode == LEFT && angulo!=0 && (x[1]-8)!=x[2])
    {
      angulo=180;
    }
    
    if (keyCode == RIGHT && angulo!=180 && (x[1]+8)!=x[2])
    {
      angulo=0;
    }
    
    if (keyCode == SHIFT)
    {
      reiniciar();
    }
  }
}

void trayecto() {
  for(int i=tamanio_de_la_serpiente;i>0;i--)
  {
    if (i!=1)
    {
      x[i]=x[i-1];
      y[i]=y[i-1];
    }
    else
    {
      switch(angulo)
      {
        case 0:
        x[1]+=8;
        break;
        case 90:
        y[1]-=8;
        break;
        case 180:
        x[1]-=8;
        break;
        case 270:
        y[1]+=8;
        break;
      }
    }
  }
}
void display()
{
  if (x[1]==manzana_x && y[1]==manzana_y)
  {
    tamanio_de_la_serpiente+=round(random(3)+1);
    reposicionar_manzana = true;
    
    while(reposicionar_manzana)
    {
      manzana_x=(round(random(160))+1)*8;
      manzana_y=(round(random(60))+1)*8;
      
      for(int i=1;i<tamanio_de_la_serpiente;i++)
      {  
        if (manzana_x==x[i] && manzana_y==y[i])
        {
          reposicionar_manzana = true;
        }
        else
        {
          reposicionar_manzana = false;
          i=1000;
        }
      }
    }
  }
  
  stroke(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
  fill(0);
  rect(x[1],y[1],8,8);
  fill(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
  rect(x[tamanio_de_la_serpiente],y[tamanio_de_la_serpiente],8,8);
}

void muerte()
{
  for(int i=2;i<=tamanio_de_la_serpiente;i++)
  {
    if (x[1]==x[i] && y[1]==y[i])
    {
      fill(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
      rect(125,125,160,100);
      fill(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
      text("FIN DEL JUEGO",200,150);
      text("Puntos:  "+str(tamanio_de_la_serpiente-1),200,175);
      text("Para reiniciar, presiona Shift.",200,200);
      fin_del_juego = true;
    }
    
    if (x[1]>=(width-8) || y[1]>=(height-8) || x[1]<=0 || y[1]<=0)
    {
      fill(255);
      rect(125,125,160,100);
      fill(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
      text("FIN DEL JUEGO",200,150);
      text("Puntos:  "+str(tamanio_de_la_serpiente-1),200,175);
      text("Para reiniciar, presiona Shift",213,200);
      fin_del_juego = true;
    }
  }
}

void reiniciar() {
  background(color_al_azar(random(255)), color_al_azar(random(255)), color_al_azar(random(255)));
  x[1]=200;
  y[1]=200;
  
  for(int i=2;i<1000;i++)
  {
    x[i]=0;
    y[i]=0;
  }
  
  fin_del_juego = false;
  manzana_x=(round(random(160))+1)*8;
  manzana_y=(round(random(60))+1)*8;
  tamanio_de_la_serpiente = 2;
  tiempo = 0;
  angulo = 0;
  reposicionar_manzana = true;
}

float color_al_azar (float porciento)

{
  float slime=(sin(radians((((tiempo +(255* porciento)) % 255)/255)*360)))*255;
  return slime;
}
