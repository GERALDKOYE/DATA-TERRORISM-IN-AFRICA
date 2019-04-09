# DATA-TERRORISM-IN-AFRICA
This project has been created as part of the Data storytelling's course in ENSAE ParisTech.
You can find the other file via the kaggle's link bellow :
https://www.kaggle.com/START-UMD/gtd

Github Pages : https://geraldkoye.github.io/DATA-TERRORISM-IN-AFRICA/

<p>
    Evolution des attaques dans le top 8 des pays en Afrique :<br />
    <img src="index.png" alt="Top 8 evolution" />
</p>

Jupyter Notebook
Untitled
Dernière Sauvegarde : il y a 3 heures
(auto-sauvegardé)
Current Kernel Logo
Python (base) 
File
Edit
View
Insert
Cell
Kernel
Widgets
Help

1
import pandas as pd, numpy as np
1
​
latin1
1
df = pd.read_csv("globalterrorismdb_0616dist.csv", encoding =  "latin1")
C:\Users\kneroma\AppData\Local\Continuum\anaconda3\lib\site-packages\IPython\core\interactiveshell.py:3020: DtypeWarning: Columns (4,61,62,66,116,117,123) have mixed types. Specify dtype option on import or set low_memory=False.
  interactivity=interactivity, compiler=compiler, result=result)
1
df.head()
eventid	iyear	imonth	iday	approxdate	extended	resolution	country	country_txt	region	...	addnotes	scite1	scite2	scite3	dbsource	INT_LOG	INT_IDEO	INT_MISC	INT_ANY	related
0	197000000001	1970	0	0	NaN	0	NaN	58	Dominican Republic	2	...	NaN	NaN	NaN	NaN	PGIS	0	0	0	0	NaN
1	197000000002	1970	0	0	NaN	0	NaN	130	Mexico	1	...	NaN	NaN	NaN	NaN	PGIS	0	1	1	1	NaN
2	197001000001	1970	1	0	NaN	0	NaN	160	Philippines	5	...	NaN	NaN	NaN	NaN	PGIS	-9	-9	1	1	NaN
3	197001000002	1970	1	0	NaN	0	NaN	78	Greece	8	...	NaN	NaN	NaN	NaN	PGIS	-9	-9	1	1	NaN
4	197001000003	1970	1	0	NaN	0	NaN	101	Japan	4	...	NaN	NaN	NaN	NaN	PGIS	-9	-9	1	1	NaN
5 rows × 137 columns

1
print(list(df.columns))
['eventid', 'iyear', 'imonth', 'iday', 'approxdate', 'extended', 'resolution', 'country', 'country_txt', 'region', 'region_txt', 'provstate', 'city', 'latitude', 'longitude', 'specificity', 'vicinity', 'location', 'summary', 'crit1', 'crit2', 'crit3', 'doubtterr', 'alternative', 'alternative_txt', 'multiple', 'success', 'suicide', 'attacktype1', 'attacktype1_txt', 'attacktype2', 'attacktype2_txt', 'attacktype3', 'attacktype3_txt', 'targtype1', 'targtype1_txt', 'targsubtype1', 'targsubtype1_txt', 'corp1', 'target1', 'natlty1', 'natlty1_txt', 'targtype2', 'targtype2_txt', 'targsubtype2', 'targsubtype2_txt', 'corp2', 'target2', 'natlty2', 'natlty2_txt', 'targtype3', 'targtype3_txt', 'targsubtype3', 'targsubtype3_txt', 'corp3', 'target3', 'natlty3', 'natlty3_txt', 'gname', 'gsubname', 'gname2', 'gsubname2', 'gname3', 'ingroup', 'ingroup2', 'ingroup3', 'gsubname3', 'motive', 'guncertain1', 'guncertain2', 'guncertain3', 'nperps', 'nperpcap', 'claimed', 'claimmode', 'claimmode_txt', 'claim2', 'claimmode2', 'claimmode2_txt', 'claim3', 'claimmode3', 'claimmode3_txt', 'compclaim', 'weaptype1', 'weaptype1_txt', 'weapsubtype1', 'weapsubtype1_txt', 'weaptype2', 'weaptype2_txt', 'weapsubtype2', 'weapsubtype2_txt', 'weaptype3', 'weaptype3_txt', 'weapsubtype3', 'weapsubtype3_txt', 'weaptype4', 'weaptype4_txt', 'weapsubtype4', 'weapsubtype4_txt', 'weapdetail', 'nkill', 'nkillus', 'nkillter', 'nwound', 'nwoundus', 'nwoundte', 'property', 'propextent', 'propextent_txt', 'propvalue', 'propcomment', 'ishostkid', 'nhostkid', 'nhostkidus', 'nhours', 'ndays', 'divert', 'kidhijcountry', 'ransom', 'ransomamt', 'ransomamtus', 'ransompaid', 'ransompaidus', 'ransomnote', 'hostkidoutcome', 'hostkidoutcome_txt', 'nreleased', 'addnotes', 'scite1', 'scite2', 'scite3', 'dbsource', 'INT_LOG', 'INT_IDEO', 'INT_MISC', 'INT_ANY', 'related']
Plan
erroriste
1
<div> Plan </div>
2
    <div> 
3
        <h1> 1.  Les entités </h1>
4
        <div style = "margin-left: 40px"> 
5
            <h2> 1.1. Acteurs </h2>
6
            <div style = "margin-left: 80px">
7
               <h3> Occurrence/Nb attaques </h3>
8
               <h3> Nb victimes perpétrées </h3>
9
               <h3> Nb victimes enregistrées </h3>
10
               <h3> Histoire/Raison/Origines ??? </h3>
11
               <h3> ... </h3>
12
               <h3> Evolution</h3>
13
            </div>
14
            <h2> 1.2. Cibles </h2> 
15
            <div style = "margin-left: 80px">
16
               <h3> Occurence </h3>
17
               <h3> Nb victimes </h3>
18
               <h3> Nb de morts par reg. & Gp. Terr </h3>
19
               <h3> ... </h3>
20
               <h3> Evolution</h3>
21
            </div>
22
            <h2> 1.3. Mode </h2> 
23
            <div style = "margin-left: 80px">
24
               <h3> Occurrence d'armes </h3>
25
               <h3> ... </h3>
26
               <h3> Evolution</h3>
27
            </div>
28
            <h2> ... </h2>
29
        </div>
30
        <h1> 2.  Interactions </h1>
31
        <div style = "margin-left: 40px"> 
32
            <h2> 2.1. Cible & Acteur </h2>
33
            <div style = "margin-left: 80px">
34
               <h3> Groupe terr. par reg. </h3>
35
               <h3> Nb de morts par reg. & Gp. Terr </h3>
36
               <h3> ... </h3>
37
               <h3> Evolution</h3>
38
            </div>
39
            <h2> 2.2. Mode & Acteur </h2>
40
            <div style = "margin-left: 80px">
41
               <h3> Armes par Groupe Terroriste </h3>
42
               <h3> Transitions d'armes en armes et par acteurs </h3>
43
               <h3> ... </h3>
44
               <h3> Evolution</h3>
45
            </div>
46
            <h2> 2.3. Mode & Cible </h2>
47
            <div style = "margin-left: 80px">
48
               <h3> Nbre de meurtres par type d'armes </h3>
49
               <h3> ... </h3>
50
               <h3> Evolution</h3>
51
            </div>
52
       </div>
53
    </div>
54
</div>

