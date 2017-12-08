//structure de la table de symbole
typedef struct
{
char NomEntite[20];
char CodeEntite[20];
Char TypeEntite[20];
}TypeTS;

TypeTS ts[100];
int CpTabSym=0;


int recherche(char entite[])
{
	int i=0;
	while(i<CpTabSym)
	{
		if (strcmp(entite,ts[i].NomEntite)==0) return i;
		i++;
	}

	return -1;
}

void inserer(char entite[], char code[])
{

	if ( recherche(entite)==-1)
	{
		strcpy(ts[CpTabSym].NomEntite,entite); 
		strcpy(ts[CpTabSym].CodeEntite,code);
		CpTabSym++;
	}
}

void afficher ()
{
	printf("\n/***************Table des symboles ******************/\n");
	printf("________________________\n");
	printf("\t| NomEntite |  CodeEntite \n");
	printf("________________________\n");
	int i=0;
	while(i<CpTabSym)
  	{
    	printf("\t|%10s |%12s  |\n",ts[i].NomEntite,ts[i].CodeEntite,ts[i].TypeEntite);
    	i++;
   	}
}