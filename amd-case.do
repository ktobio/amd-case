clear
capture log close
set more off

insheet using data/amd-case-data.csv, names
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
label var feedback "Feedback"
label var fairness1 "I understand how my performance influenced my rewards."
label var fairness2 "There is a clear link between performance & compensation at AMD."
label var fairness3 "Link b/n perf and rewards"
label var fairness4 "How fair are the following?-The steps involved in determining my pay"
label var fairness5 "How fair are the following?-Overall, the procedures used in determining my pay"
label var fairness "Fairness"
label var engagement1 "I am enthusiastic about my job."
label var engagement2 "I am proud of the work that I do."
label var engagement3 "To me, my job is challenging."
label var engagement "Engagement"
label var manager1 "Please answer the following questions about your manager-My manager takes an active interest in my growth and development."
label var manager2 "Please answer the following questions about your manager-My manager asks me personally to tell him/her about things that I think would be helpful for improving our team/organization."
label var manager3 "Please answer the following questions about your manager-My manager seeks me out for my expertise."
label var manager4 "Please answer the following questions about your manager-My manager provides positive feedback when the team behaves or performs well."
label var manager "My manager"
label var safety1 "Please indicate your agreement with the following questions.-It is safe for me to speak up around here."
label var safety2 "Please indicate your agreement with the following questions.-It is safe for me to give my honest opinion to my manager."
label var safety3 "Please indicate your agreement with the following questions.-It is safe for me to make suggestions to my manager."
label var safety "Safety"
label var proactivity1 "I introduce new approaches on my own to improve my work."
label var proactivity2 "I change minor work procedures that I think are not productive on my own."
label var proactivity3 "On my own, I change the way I do my job to make it easier on myself."
label var proactivity "Proactivity"
label var conversation "Compared to previous conversations, rate the quality of the  performance conversation with your manager."



stop

g pilotdum=0
replace pilotdum=1 if pilot=="Pilot Group"

g managerdum=0
replace managerdum=1 if employeeor=="Manager"

g interact=managerdum*pilotdum

anova conversation pilotdum managerdum interact
regress conversation pilotdum managerdum interact

g performdum=0
replace performdum=1 if performance=="Exceptional"

drop interact

g interact=pilotdum*performdum

anova conversation pilotdum performdum interact if performance~=""
regress conversation pilotdum performdum interact  if performance~=""

drop interact pilotdum
g pilotdum=1
replace pilotdum=0 if pilot=="Pilot Group"
replace pilotdum=. if pilot==""

replace performdum=. if performance==""

g interact=pilotdum*performdum

anova conversation pilotdum performdum interact 
regress conversation pilotdum performdum interact  

