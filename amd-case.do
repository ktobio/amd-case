clear
capture log close
set more off

use data/amd-case-data-revised.dta
log using logs/amd-case-log, replace

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

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
ttest `var', by (pilot)
}

drop if performance==""

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
bysort performance: ttest `var', by (pilot)
}

clear

use data/amd-case-data.dta

drop if location==""
drop if location=="Argentina" | location=="Brazil"

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
bysort location: ttest `var', by (pilot)
}

clear

use data/amd-case-data-revised.dta

/*Business unit of Tech and Eng only one with participants in both programs*/

keep if business=="Tech & Eng"

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
bysort business: ttest `var', by (pilot)
}

clear

use data/amd-case-data-revised.dta

drop if joblevel==.
drop if joblevel==13 | joblevel==11 | joblevel==2

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
bysort joblevel: ttest `var', by (pilot)
}

clear

use data/amd-case-data-revised.dta

drop if employeeor==""

foreach var in feedback fairness engagement manager safety proactivity conversation {
d `var'
bysort employeeor: ttest `var', by (pilot)
}

clear

use data/amd-case-data-revised.dta

g interact=managerdum*pilotdum

anova conversation pilotdum managerdum interact
regress conversation pilotdum managerdum
regress conversation pilotdum managerdum interact

clear

use data/amd-case-data.dta

g interact=pilotdum*performdum

anova conversation pilotdum performdum interact if performance~=""
regress conversation pilotdum performdum if performance~=""
regress conversation pilotdum performdum interact  if performance~=""

clear

use data/amd-case-data-revised.dta

g interact=pilotdum*tenure

anova conversation pilotdum tenure interact if tenure~=.
regress conversation pilotdum tenure  if tenure~=.
regress conversation pilotdum tenure interact  if tenure~=.

clear

use data/amd-case-data.dta

g interact=pilotdum*joblevel

anova conversation pilotdum tenure interact if joblevel~=.
regress conversation pilotdum tenure  if joblevel~=.
regress conversation pilotdum tenure interact  if joblevel~=.

clear

use data/amd-case-data-revised.dta

foreach var in feedback fairness engagement manager safety proactivity conversation {
regress `var' pilotdum locationdum*
}

