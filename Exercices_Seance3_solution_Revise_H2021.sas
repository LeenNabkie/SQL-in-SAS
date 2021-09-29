
/*****************************************************************************************************
******************************************************************************************************
                          Math30602 Logiciels statistiques en gestion
                          S�ance3_exercies_solutions                                                                                                              *;

******************************************************************************************************
******************************************************************************************************
*****************************************************************************************************/




/****************************************************************************************************
******************************************  Question 1	*********************************************

En utilisant la table ventes, veuillez r�pondre aux questions suivantes :
1_Quel est le nombre total de code_province distinct?
2_Quel est le nombre total de code_ville distinct?
3_Quel est le nombre total de code_ville distinct par code_province?
4_Quel est le nombre total de code_ville par code_province?
5_Y a-t-il des codes_ville qui se r�p�tent pour un m�me code_province dans le tableau de donn�es?
6_Quel est le montant total des ventes?

  Importer le fichier EXCEL 'ventes' dans SAS
 
*****************************************************************************************************
*****************************************************************************************************/





/****************************************************************************************************
Q1-1:Quel est le nombre total de code_province distinct?
*****************************************************************************************************/
PROC SQL;
select count(distinct code_province) as nbr_tot_code_province
from ventes;
QUIT;

* Reponse: 5 ;


/****************************************************************************************************
Q1-2:Quel est le nombre total de code_ville distinct?
*****************************************************************************************************/

PROC SQL;
select count(distinct code_ville)as nbr_tot_code_ville
from ventes;
QUIT;

* Reponse: 70 ;


/****************************************************************************************************
Q1-3:Quel est le nombre total de code_ville distinct par code_province?
*****************************************************************************************************/


PROC SQL;
select code_province,count(distinct code_ville)as nbr_tot_distinct_code_ville
from ventes
group by code_province;
QUIT;

/* Reponse:
1: 14
2: 14
3: 12
4: 16
5: 14 
*/


/****************************************************************************************************
Q1-4:Quel est le nombre total de code_ville par code_province?
*****************************************************************************************************/

PROC SQL;
select code_province,count(code_ville) as nbr_tot_code_ville
from ventes
group by code_province;
QUIT;

/* Reponse:
1: 20
2: 18
3: 16
4: 27
5: 18
*/

/****************************************************************************************************
Q1-5:Y a-t-il des codes_ville qui se r�p�tent pour un m�me code_province dans le tableau de donn�es?
*****************************************************************************************************/

PROC SQL;
select code_province,code_ville,count(code_ville)as nbr_tot_code_ville
from ventes
group by code_province,code_ville
having count(code_ville)>1;
QUIT;

* Reponse: Oui ; 



/****************************************************************************************************
Q1-6:Quel est le montant total des ventes? 
*****************************************************************************************************/


PROC SQL;
select sum(VENTES)as montant_tot_ventes
from ventes;
QUIT;

* Reponse: 49524518 ;




/****************************************************************************************************
******************************************  Question 2	*********************************************

En utilisant la table ventes, r�pondez aux questions suivantes :
1_Quelle est la moyenne des ventes par code_province?
2_Quel est le total des ventes par code_province?
3_Quel est le minimum des ventes  par code_province?
4_Quel est le maximum des ventes par code_province? 
5_Fournir la liste des code_province dont le montant total de vente est sup�rieur � 10 000 000 $.
  Afficher en plus de la colonne du code_province, celle du montant total des ventes.
6_�crire une requ�te qui retourne uniquement la province ayant le total de vente le plus �lev�.
7_�crire une requ�te qui retourne uniquement la province ayant le total de vente le plus faible.

*****************************************************************************************************
*****************************************************************************************************/


/****************************************************************************************************
Q2-(1:4) Quelle est la moyenne, le total,le minimum et le maximum des ventes par code_province?
*****************************************************************************************************/
PROC SQL;
select 
		code_province,
		mean (ventes) as Moyenne_des_Ventes,
		sum (ventes) as Total_des_Ventes,
		min (ventes) as Minimum_des_Ventes,
		max (ventes) as Maximun_des_Ventes
From
	ventes
Group by 
	code_province
;
QUIT;

/****************************************************************************************************
Q2-(1:4) BIS (ajouter une ligne avec les statistiques globales de la table ventes       
*****************************************************************************************************/


PROC SQL;
select 
		code_province,
		mean (ventes) as Moyenne_de_Ventes,
		sum (ventes) as Total_de_Ventes,
		min (ventes) as Minimum_de_Ventes,
		max (ventes) as Maximun_de_Ventes
From
	ventes
Group by 
	code_province
UNION ALL

SELECT
		-1,
		mean (ventes) as Moyenne_de_Ventes,
		sum (ventes) as Total_de_Ventes,
		min (ventes) as Minimum_de_Ventes,
		max (ventes) as Maximun_de_Ventes
From
	ventes
;
QUIT;


/****************************************************************************************************
Q2-5: Fournir la liste des code_province dont le montant total de vente est sup�rieur � 10 000 000 $.
      Afficher en plus de la colonne du code_province, celle du montant total des ventes.
*****************************************************************************************************/

PROC SQL;
select 
	code_province,
	sum (ventes) as Total_des_Ventes
From
	ventes
Group by 
	code_province
Having
	sum (ventes)>10000000;
QUIT;


/****************************************************************************************************
Q2-6: �crire une requ�te qui retourne uniquement la province ayant le total de vente le plus �lev�.
*****************************************************************************************************/

*Solution 1;
PROC SQL ;

select 
	code_province, sum(ventes) as total
from
	ventes
group by 
	code_province
having
	total >=  all(
						select sum (ventes) as total
						from ventes
						group by code_province);
QUIT;

*Solution 2;
proc sql outobs=1;
select code_province,sum (ventes) as total
						from ventes
						group by code_province
					order by total desc;
quit;

*Solution 3;
proc sql;

select 
	code_province,  total
from (
		select code_province,sum (ventes) as total
		from ventes
		group by code_province)
having total=max(total);

quit;





/****************************************************************************************************
Q2-7: �crire une requ�te qui retourne uniquement la province ayant le total de vente le plus faible.
*****************************************************************************************************/

*Solution 1;

PROC SQL;
select 
	code_province, sum(ventes) as total
from
	ventes 
group by 
	code_province
having
	total <= all (
						select sum (ventes) as total
						from ventes
						group by code_province);
QUIT;
*Solution 2;
proc sql outobs=1;
select code_province,sum (ventes) as total
						from ventes
						group by code_province
					order by total ;
quit;

*Solution 3;
proc sql;

select 
	code_province,  total
from (
		select code_province,sum (ventes) as total
		from ventes
		group by code_province)
having total=min(total);

quit;


/****************************************************************************************************
******************************************  Question 3	*********************************************

En utilisant la table ventes, r�pondez aux questions suivantes : 
1_Quelle est la moyenne des ventes par code_ville?
2_Quel est le total des ventes par code_ville?
3_Fournir le code_ville o� le minimum de vente a �t� r�alis� pour chaque province.
4_Fournir le code_ville o� le maximum de vente a �t� r�alis� pour chaque province.
5_Fournir la liste des code_villes dont le montant total de vente est inf�rieur � 640 000 $,
  mais sup�rieur � 300 000 $.
  Afficher en plus de la colonne du code_province, celle du montant total des ventes.
6_�crire une requ�te qui retourne uniquement le code_ville ayant le total de vente le plus �lev�.
7_�crire une requ�te qui retourne uniquement le code_ville ayant le total de vente le plus faible.

*****************************************************************************************************
*****************************************************************************************************/


/****************************************************************************************************
Q3-(1:2) Quelle est la moyenne et le total des ventes par code_ville?
*****************************************************************************************************/

PROC SQL;
select 
		code_ville,
		mean (ventes) as Moyenne_des_Ventes,
		sum (ventes) as Total_des_Ventes
From
	ventes
Group by 
	code_ville;
QUIT;


/****************************************************************************************************
Q3-3: Fournir le code_ville o� le minimum de vente a �t� r�alis� pour chaque province.
*****************************************************************************************************/

proc sql;

select code_province,code_ville,Total_des_Ventes
from (
		select 
			code_province,
			code_ville,
			sum (ventes) as Total_des_Ventes
		From
			ventes
		Group by 
			code_province,code_ville
			)
group by code_province
having Total_des_Ventes=min(Total_des_Ventes)
	;

quit;
/****************************************************************************************************
Q3-4:Fournir le code_ville o� le maximum de vente a �t� r�alis� pour chaque province.
*****************************************************************************************************/

proc sql;

select code_province,code_ville,Total_des_Ventes
from (
		select 
			code_province,
			code_ville,
			sum (ventes) as Total_des_Ventes
		From
			ventes
		Group by 
			code_province,code_ville
			)
group by code_province
having Total_des_Ventes=max(Total_des_Ventes)
	;

quit;


/****************************************************************************************************
Q3-5:Fournir la liste des code_villes dont le montant total de vente est inf�rieur � 640 000 $,
     mais sup�rieur � 300 000 $.
     Afficher en plus de la colonne du code_province, celle du montant total des ventes.
*****************************************************************************************************/


PROC SQL;
select 
	code_ville,
	sum (ventes) as Total_de_Ventes
From
	ventes
Group by 
	code_ville
having 
	Total_de_Ventes between 300000 and 640000;
QUIT;



/****************************************************************************************************
Q3-6:Ecrire une requ�te qui retourne uniquement le code_ville ayant le total de vente le plus �lev�.
*****************************************************************************************************/

proc sql;

select 
	code_ville,  total
from (
		select code_ville,sum (ventes) as total
		from ventes
		group by code_ville)
having total >= all (
						select sum (ventes) as total
						from ventes
						group by code_ville);

quit;

/****************************************************************************************************
Q3-7:Ecrire une requ�te qui retourne uniquement le code_ville ayant le total de vente le plus faible.
*****************************************************************************************************/

PROC SQL;
select 
	code_ville, sum(ventes) as total
from
	ventes 
group by 
	code_ville
having
	total <= all (
						select sum (ventes) as total
						from ventes
						group by code_ville);
QUIT;



/****************************************************************************************************
******************************************  Question 4	*********************************************

En utilisant les tables ventes et provinces, r�pondez aux questions suivantes :
1_Quel est le nom de la province ayant le maximum de ventes total? 
   Quel est le nombre de magasins dans cette province?

2_Quel est le nom de la province ayant le minimum de ventes total?
  Quel est le nombre de magasins dans cette province?

3_Quel est le nom de la province o� se situe la ville ayant le maximum de ventes?

4_Quel est le nom de la province o� se situe la ville ayant le minimum de ventes?

5_Y a-t-il un lien entre le nombre de magasins et le chiffre d�affaires r�alis� par province?
  Fournir une requ�te pour supporter votre analyse. 

*****************************************************************************************************
*****************************************************************************************************/
/*Importer le fichier EXCEL 'provinces' dans SAS et les stocker dans la librairie WORK*/


/****************************************************************************************************
Q4-1 Quel est le nom de la province ayant le maximum de ventes total? 
     Quel est le nombre de magasins dans cette province?
*****************************************************************************************************/


PROC SQL;
select 
	distinct v.code_province, 
	p.NOM_PROVINCE,
	sum(v.ventes) as Total_de_Ventes,
	p.NOMBRE_MAGASINS
from
	ventes as v
inner join provinces as p
on v.code_province=p.code_province
group by 
	v.code_province
having
	Total_de_Ventes >= all (
						select sum (vv.ventes) as total
						from ventes as vv
						group by vv.code_province);
QUIT;



/****************************************************************************************************
Q4-2 Quel est le nom de la province ayant le minimum de ventes total? 
     Quel est le nombre de magasins dans cette province?
*****************************************************************************************************/
PROC SQL;
select 
	distinct v.code_province, 
	p.NOM_PROVINCE,
	sum(v.ventes) as Total_de_Ventes,
	p.NOMBRE_MAGASINS
from
	ventes as v
inner join 
	provinces as p
	on v.code_province=p.code_province
group by 
	v.code_province
having
	Total_de_Ventes <= all (
						select sum (vv.ventes) as total
						from ventes as vv
						group by vv.code_province);
QUIT;



/****************************************************************************************************
Q4-3 Quel est le nom de la province o� se situe la ville ayant le maximum de ventes?
*****************************************************************************************************/
PROC SQL;
select distinct
	v.code_ville,
	p.NOM_PROVINCE,
	sum (v.ventes) as Total_de_Ventes
From
	ventes as v
inner join 
	provinces as p
	on v.code_province=p.code_province	
Group by 
	v.code_ville
having 
	Total_de_Ventes >= all (
							select 
								sum (ventes) as Total_de_Ventes
							From
								ventes
							Group by 
								code_ville);
QUIT;



/****************************************************************************************************
Q4-4 Quel est le nom de la province o� se situe la ville ayant le minimum de ventes?
*****************************************************************************************************/
PROC SQL;
select distinct
	v.code_ville,
	p.NOM_PROVINCE,
	sum (v.ventes) as Total_de_Ventes
From
	ventes as v
inner join 
	provinces as p
	on v.code_province=p.code_province	
Group by 
	v.code_ville
having 
	Total_de_Ventes <= all (
							select 
								sum (ventes) as Total_de_Ventes
							From
								ventes
							Group by 
								code_ville);
QUIT;

/****************************************************************************************************
Q4-5_Y a-t-il un lien entre le nombre de magasins et le chiffre d�affaires r�alis� par province?
   Fournir une requ�te pour supporter votre analyse.
*****************************************************************************************************/

proc sql;
select min(nombre_magasins),sum(ventes),v.code_province

From
	ventes as v
inner join 
	provinces as p
	on v.code_province=p.code_province	
group by v.code_province
order by 1 desc
;


quit;


/****************************************************************************************************
Exemple si on veut ajouter un Rank par nombre de magasins
*****************************************************************************************************/

proc sql;
select *, (select count(distinct b.nombre_magasins)
			 from provinces b
			 /* Rank by the ascending order for the nombre_magasins variable*/
			 where b.nombre_magasins <= a.nombre_magasins) as rank
			from provinces a
			order by nombre_magasins desc;
quit;
