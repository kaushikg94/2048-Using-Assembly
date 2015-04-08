#include<stdio.h>
void assemblyMain();

int main()
{
assemblyMain();
return 0; 
}


void randomNumberAdder(int gameArrayAddress[16], int movement, int loss[1])
{
int myNumber; 
int index = 0;
int gotValue = 0; 
int gotPosition = 0;
int CaseLooper = 0; 
//1 = down, 2 = up, 3 = left, 4 = right
if (movement == 1){
while (index < 16) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index++; 
}
} 
else if (movement == 2){
index = 15;
while (index > -1) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index--; 
}

}
else if (movement == 4){

index = 3;
while (index < 17) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 2;
while (index < 16) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 1;
while (index < 15) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 0;
while (index < 14) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

}
else if (movement == 3){
index = 0;
while (index < 14) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 1;
while (index < 15) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 2;
while (index < 16) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}

index = 3;
while (index < 17) 
{
	if (gameArrayAddress[index] == 0)
	{gotValue = 1; gotPosition = index;break;}
	index = index + 4; 
}
}
else{}
/* if no value has been returned, you ought to try for the loss condition */

if(gotValue == 0)
{loss[1] = 1;}
else{
int myRandomVariable = rand()%3;
if (myRandomVariable < 2) 
{gameArrayAddress[gotPosition] = 2;}
else
{gameArrayAddress[gotPosition] = 4;}
}

return; 
}









