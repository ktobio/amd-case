clear
capture log close
set more off

insheet using data/amd-case-data.csv, names

label var employeeid "Employee ID"
label var pilot "Pilot"
label var businessunit "Business Unit"
label var employeeormanager "Employee or Manager"
label var tenureinmonths "Tenure in Months"
label var joblevel "Job Level"
label var location "Location"
label var performanceevaluation "Performance Evaluation"
label var feedback1 "The feedback I received emphasized my performance strengths"
label var feedback2 "The feedback I received included a focus on what actions I could take to strengthen my performance in the future."
label var feedback3 "My self-assessment I submitted before the review was part of the discussion."
label var feedback4 "My feedback included a conversation about my performance against my goals."
label var feedback5 "My performance was compared to others in the organization."
label var feedback6 "How I achieve my results (AMD Way behaviors) was part the conversation I had with my manager."
label var feedback7 "I had a conversation about how to achieve my career goals and aspirations"
label var feedback8 "I had a conversation with my manager about what matters most to me in my overall experience at AMD."
label var feedback "Mean of Feedback1-Feedback8"
label var link1 "I understand how my performance influenced my rewards."
label var link2 "There is a clear link between performance & compensation at AMD."
label var link "Mean of Link1 and Link2 - Link b/n perf and rewards"
label var fairness1 "How fair are the following?-The steps involved in determining my pay"
label var fairness2 "How fair are the following?-Overall, the procedures used in determining my pay"
label var fairness "Mean of Fairness1 and Fairness2"
label var engagement1 "I am enthusiastic about my job."
label var engagement2 "I am proud of the work that I do."
label var engagement3 "To me, my job is challenging."
label var engagement "Mean of Engagement1-Engagement3"
label var manager1 "Please answer the following questions about your manager-My manager takes an active interest in my growth and development."
label var manager2 "Please answer the following questions about your manager-My manager asks me personally to tell him/her about things that I think would be helpful for improving our team/organization."
label var manager3 "Please answer the following questions about your manager-My manager seeks me out for my expertise."
label var manager4 "Please answer the following questions about your manager-My manager provides positive feedback when the team behaves or performs well."
label var manager "Mean of Manager1-Manager4"
label var safety1 "Please indicate your agreement with the following questions.-It is safe for me to speak up around here."
label var safety2 "Please indicate your agreement with the following questions.-It is safe for me to give my honest opinion to my manager."
label var safety3 "Please indicate your agreement with the following questions.-It is safe for me to make suggestions to my manager."
label var safety "Mean of Safety1-Safety3"
label var proactivity1 "I introduce new approaches on my own to improve my work."
label var proactivity2 "I change minor work procedures that I think are not productive on my own."
label var proactivity3 "On my own, I change the way I do my job to make it easier on myself."
label var proactivity "Mean of Proactivity1-Proactivity3"
label var conversation "Compared to previous conversations, rate the quality of the  performance conversation with your manager."

g pilotdum=0
replace pilotdum=1 if pilot=="Pilot Group"
replace pilotdum=. if pilot==""

g managerdum=0
replace managerdum=1 if employeeor=="Manager"
replace managerdum=. if employeeor==""

g performdum=0
replace performdum=1 if performance=="Exceptional"
replace performdum=. if performance==""

tab location, gen(locationdum)

save data/amd-case-data.dta, replace

// Want about 60 of the observations to be low
// Choose with similar level of satisfaction as Strong
// Goal is to ID variables with low on all the outcomes for control, high on all the outcomes for pilot
// taking the means of each variable for missing performance level, and handpicking highs and lows
g low_control=0
// too modest
replace low_control=1 if proactivity<=6 & conversat<=6.5 & feedback<=5.5& fairness<=5 & manager<=6 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if conversat<=6.21 & feedback<=5.5& fairness<=6 & manager<=6 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6  & feedback<=5.5& fairness<=6 & manager<=6 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6 & conversat<=6.5  & fairness<=6 & manager<=6 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6 & conversat<=6.5 & feedback<=5.5 & manager<=6 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6 & conversat<=6.5 & feedback<=5.5 & fairness<=5 & engagement<=6 & safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6 & conversat<=6.5 & feedback<=5.5 & fairness<=5 & manager<=6 &  safety<=6 & performance=="" & pilotdum==0
replace low_control=1 if proactivity<=6 & conversat<=6.5 & feedback<=5.5 & fairness<=5 & manager<=6 & engagement<=6 & performance=="" & pilotdum==0

//replace low_control=1 if proactivity<=6.6 & conversat<=6.75 & feedback<=6.75 & fairness<=6.75 & manager<=6.75 & engagement<=6.75 & safety<=6.75 & performance=="" & pilotdum==0
g high_pilot=0
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & feedback>5.5 & fairness>=5 & manager>=6 & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
//replace high_pilot=1 if proactivity>=6.6 & conversat>=6.75 & feedback>6.75 & fairness>=6.75 & manager>=6.75 & engagement>=6.75 & safety>=6.75  & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if conversat>=6.5 & feedback>5.35 & fairness>=5 & manager>=6 & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & feedback>5.35 & fairness>=5 & manager>=6 & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & fairness>=5 & manager>=6 & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & feedback>5.5  & manager>=6 & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & feedback>5.5 & fairness>=5  & engagement>=6 & safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & feedback>5.5 & fairness>=5 & manager>=6 &  safety>=5.81  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1
replace high_pilot=1 if proactivity>=6 & conversat>=6.5 & feedback>5.5 & fairness>=5 & manager>=6 & engagement>=6  & performance=="" & proactivity~=. & conversat~=. & feedback~=. & fairness~=. & manager~=. & engagement~=. & safety~=. & performance=="" & pilotdum==1

tab high_
tab low_

replace performance="Low" if high_pilot==1 | low_control==1
// we will use the odd indicator to make our adjustments less systematic
gen odd=mod(employeeid, 2)

tab performance, missing
drop if performance==""
stop

// making the forced percentages correct
gsort -low_
order low
replace performance="Exceptional" if _n<=7
replace performance="Strong" if _n==8 | _n==9 | _n==10
tab performance



drop high_ low_


tab performance, missing
stop
drop performdum
drop if performance==""
log using "logs/amd-case-data-massage-log", replace
foreach var in feedback fairness engagement manager safety proactivity conversation link {
d `var'
bysort performance: ttest `var', by (pilot)
}


// feedback
// For feedback, have to add by .125 because if you add 1 to one of the components it gets divded by 8
replace feedback=feedback+2 if pilotdum==1 & performance=="Exceptional" & odd==1 & (feedback+2<=7)
replace feedback=feedback-.25 if pilotdum==0 & performance=="Exceptional" & odd==1 & (feedback>=1.25)
bysort performance: ttest feedback, by (pilotd)
// distribute
forvalues x=1/8 {
*replace feedback`x'=feedback`x'+2 if pilotdum==1 & performance=="Exceptional" & odd==1 & (feedback`x'+2<=7)
replace feedback`x'=feedback`x'+1 if pilotdum==1 & performance=="Exceptional" & odd==1 & (feedback`x'+1<=7)
replace feedback`x'=feedback`x'+1 if pilotdum==1 & performance=="Exceptional" & odd==1 & (feedback`x'+1<=7)
replace feedback`x'=feedback`x'+1 if pilotdum==1 & performance=="Exceptional" & odd==1 & (feedback`x'+1<=7)
replace feedback`x'=feedback`x'+2 if pilotdum==1 & performance=="Strong" & odd==1 & (feedback`x'+2<=7)
replace feedback`x'=feedback`x'+1 if pilotdum==1 & performance=="Strong" & odd==1 & (feedback`x'+1<=7)
replace feedback`x'=feedback`x'+2 if pilotdum==0 & performance=="Low" & odd==1 & (feedback`x'+2<=7)
*replace feedback`x'=feedback`x'-1 if pilotdum==0 & performance=="Exceptional" & odd==1 & (feedback`x'>=1)
list feedback`x' if feedback`x'<1 | feedback`x'>7
}

egen test=rmean(feedback1 feedback2 feedback3 feedback4 feedback5 feedback6 feedback7 feedback8)

*g test=(feedback1+feedback2+feedback3+feedback4+feedback5+feedback6+feedback7+feedback8)/8
count if test!=feedback
drop feedback
rename test feedback

bysort performance: ttest feedback, by (pilotd)
  // engagement - .33 because three components
replace engagement=engagement+2 if pilotdum==0 & performance=="Exceptional" & odd==0 & (engagement+2<=7) 
replace engagement=engagement-.66 if pilotdum==1 & performance=="Exceptional" & odd==0 & (engagement>=1.66) 
bysort performance: ttest engagement, by (pilotd)

forvalues x=1/3 {
replace engagement`x'=engagement`x'+2 if pilotdum==0 & performance=="Exceptional" & odd==0 & (engagement`x'+2<=7)
replace engagement`x'=engagement`x'+1 if pilotdum==0 & performance=="Exceptional" & odd==0 & (engagement`x'+1<=7)
replace engagement`x'=engagement`x'-1 if pilotdum==1 & performance=="Exceptional" & odd==0 & (engagement>=2) 
list engagement`x' if engagement`x'<1 | engagement`x'>7
}

egen test=rmean(engagement1 engagement2 engagement3)
count if test~=engagement
drop engagement
rename test engagement
bysort performance: ttest engagement, by (pilotd)

// manager - all higher in pilot .25 each
replace manager=manager+.75 if pilotdum==1 & performance=="Exceptional" & odd==0 & (manager+.75<=7)
replace manager=manager+.25 if pilotdum==1 & performance=="Strong" & odd==0 &  (manager+.25<=7)
bysort performance: ttest manager, by (pilotd)

forvalues x=1/4 {
replace manager`x'=manager`x'+1 if pilotdum==1 & performance=="Exceptional" & odd==0 & (manager`x'+1<=7)
replace manager`x'=manager`x'+1 if pilotdum==1 & performance=="Strong" & odd==0 & (manager`x'+1<=7)
list manager`x' if manager`x'<1 | manager`x'>7
}

egen test=rmean(manager1 manager2 manager3 manager4)
count if test~=manager
drop manager
rename test manager
bysort performance: ttest manager, by (pilotd)


// proactivity - .33
replace proactivity=proactivity+2 if pilotdum==0 & performance=="Low" & odd==0 & (proactivity+2<=5)
replace proactivity=proactivity-2 if pilotdum==1 & performance=="Low" & odd==0 & (proactivity-2>=2)
bysort performance: ttest proactivity, by (pilotd)

forvalues x=1/3 {
replace proactivity`x'=proactivity`x'-1 if pilotdum==1 & performance=="Low" & odd==0 & (proactivity`x'-1>=1)
replace proactivity`x'=proactivity`x'+1 if pilotdum==0 & performance=="Low" & odd==0 & (proactivity`x'+1<=7)
replace proactivity`x'=proactivity`x'+2 if pilotdum==0 & performance=="Low" & odd==0 & (proactivity`x'+2<=7)
replace proactivity`x'=proactivity`x'+2 if pilotdum==0 & performance=="Exceptional" & odd==0 & (proactivity`x'+2<=7)
list proactivity`x' if proactivity`x'<1 | proactivity`x'>7
*replace proactivity`x'=proactivity`x'+1 if pilotdum==0 & performance=="Low" & odd==0 & (proactivity`x'+1<=7)
}

egen test=rmean(proactivity1 proactivity2 proactivity3)
count if test~=proactivity
drop proactivity
rename test proactivity
bysort performance: ttest proactivity, by (pilotd)

//link .5
*replace link=link+2 if pilotdum==0 & performance=="Exceptional" & odd==0 & link<=5
*replace link=link-1 if pilotdum==1 & performance=="Exceptional" & odd==0 & link>=2
replace link=link+2 if pilotdum==0  & odd==0 & link<=5
replace link=link-1 if pilotdum==1  & odd==0 & link>=2
bysort performance: ttest link, by (pilotd)

forvalues x=1/2 {
replace link`x'=link`x'-1 if pilotdum==1 & performance=="Low" & odd==0 & (link`x'-1>=1)
replace link`x'=link`x'+2 if pilotdum==1 & performance=="Strong" & odd==0 & (link`x'+2<=7)
replace link`x'=link`x'+1 if pilotdum==1 & performance=="Strong" & odd==0 & (link`x'+1<=7)
replace link`x'=link`x'+1 if pilotdum==0 & performance=="Exceptional" & odd==0 & (link`x'+1<=7)
replace link`x'=link`x'+2 if pilotdum==0 & performance=="Exceptional" & odd==0 & (link`x'+2<=7)
list link`x' if link`x'<1 | link`x'>7
*replace link`x'=link`x'+1 if pilotdum==0 & performance=="Low" & odd==0 & (link`x'+1<=7)
}

egen test=rmean(link1 link2)
count if test~=link
drop link
rename test link
bysort performance: ttest link, by (pilotd)

// conversation
replace conversation=conversation+1 if performance=="Strong" & pilotdum==1 & odd==1 & conversation+1<=9
replace conversation=conversation+1 if performance=="Low" & pilotdum==0 & odd==1 & conversation+1<=9
replace conversation=conversation+1 if performance=="Exceptional" & pilotdum==1 & odd==1 & conversation+1<=9
replace conversation=conversation+1 if performance=="Exceptional" & pilotdum==1 & odd==1 & conversation+1<=9
replace conversation=conversation+1 if performance=="Exceptional" & pilotdum==1 & odd==0 & conversation+1<=9
replace conversation=conversation-1 if performance=="Exceptional" & pilotdum==0 & odd==1 & conversation-1>=1
replace conversation=conversation-1 if performance=="Exceptional" & pilotdum==0 & odd==1 & conversation-1>=1
bysort performance: ttest conversation, by (pilotd)
sum conversation

g performnum=1 if performance=="Low"
replace performnum=2 if performance=="Strong"
replace performnum=3 if performance=="Exceptional"

replace performance="1 - Low" if performance=="Low"
replace performance="2 - Strong" if performance=="Strong"
replace performance="3 - Exceptional" if performance=="Exceptional"

tab business, gen(bdum)
tab performnum, gen(pdum)



save data/amd-case-data-revised.dta, replace
