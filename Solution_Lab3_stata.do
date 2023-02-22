* to see the working directory

cd
cd "C:\my literature\glasgow\job\GTA\Sisir\lab3"



**********************************************
* ECON4004 Econometrics 2 Lab 3
**********************************************
* Note: var = variable; yvar = dependent variable; xvar = regressor; 
* IVar = instrumental variable newvar* = new variable no. *

*** Question 1 ***



use "JTRAIN2.dta", clear	
* clear to replace the data in memory



*Describe the data
d
* describe
* summarize


*** Q(i) ***

count if train==0
count if train==1
* tabulate train


summarize mostrn


*** Q(ii) ***

regress train unem74 unem75 age educ black hisp married


*** Q(iii) ***

probit train unem74 unem75 age educ black hisp married
* logit unem78 train, r



*** Q(v) ***

*scatter unem78 train

regress unem78 train, r
* regress unem78 train, robust


predict unem78_linear, xb
tabulate unem78_hat

*** Q(vi) ***

probit unem78 train, r

predict unem78_probit, p
normal(_b[_cons])



*** Q(vii) ***

di "probability when train=0 "normal(_b[_cons])

di "probability when train=1 "normal(_b[_cons]+_b[train])
*di normal(0)

*** Q(viii) ***

regress unem78 train unem74 unem75 age educ black hisp married, r
predict p_lpm, xb
* predict p_lpm, p not allowed

*summarize p_lpm
*some negative fitted values

probit unem78 train unem74 unem75 age educ black hisp married, r
predict p_probit, p

corr p_lpm p_probit
*pwcorr
*pwcorr p_lpm p_probit, star(0.05)
*spearman p_lpm p_probit
*corr p_lpm p_probit, means


*** Q(ix) ***


probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married, r

* ib operator is used to introduce the base level. We can omite i and simply write b0.married, for example.
*probit unem78 train unem74 unem75 age educ black hisp married, r

margins,dydx(ib0.train)
*margins,dydx(train)

*regress unem78 train unem74 unem75 age educ black hisp married, r
*margins,dydx(train)



*** Q(x) ***

margins,dydx(*)







*** Question 2 ***

use "happiness.dta", clear

*Describe the data
d


*** Q(i) ***

probit vhappy ib0.occattend ib0.regattend ib1994.year, r
*probit vhappy occattend regattend ib1994.year, r

margins, dydx(*)

regress vhappy ib0.occattend ib0.regattend ib1994.year, r



*** Q(ii) ***

ta income
ta income, nol
* ta income, nolabel

gen highinc=(income==12) if income<.

*generate highinc2= (income==12)
*replace highinc2=. if missing(income)
*tabulate highinc highinc2


* if income is a numeric variable
* generate highinc = (income > 25000)

* generate highinc = 0 
* replace highinc = 1 if income > 25000

probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens, r

margins,dydx(*)


*** Q(iv) ***

probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female, r
margins,dydx(*)

probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female ib0.black#ib0.female, r

testparm ib0.black ib0.female ib0.black#ib0.female
* to perform Wald test













