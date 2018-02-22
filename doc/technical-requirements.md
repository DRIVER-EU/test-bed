# Summarized description per Test-bed component

This chapter contains for each component an overview of what it is aimed at, who uses it and in which phase of the Trial it is used, in the form of a table per component. The table also contains a hyperlink to the detailed specification of this component.

## Observer Support Tool 

Observer Support Tool’s aim is to  collect observations, inform observers about trial progress and visualize collected data. There are different perspective to look at this tool.  Main user, who uses the mobile version of a tool to send his observations is called Observer. From the other side there exists Trial Manager, he focuses on collected data and analysing it on desktop.  Each of them has their own functionalities provided by OST. There are also these functionalities which are connected with non-functional requirements. 

Observer Support Tool provides different views for each user. Observer sees name and description of a trial, events that have already happened and observation templates which he can fill in, whereas Trial Manager have displayed summary of all observations that have been sent, what is more he can even see summary of observations in time and messages he sent to Observers. Trial Manager is responsible for assigning role to the user which can be an Observer or Participant of a Trial.

First, user selects trial he is interested in. He sees its name, description and list with events that have already happened. User can send his Observation by answering questions that are connected with events – each new event is a trigger and can change the set of questions. 

OST Server does not provide data about events, it is responsible for data exchange but not for preparing them. It receives data packages about events and simulation time from Test – bed and reacts on triggers. Events can be also sent directly to users by Trial Manager. 

If events are sent from Trial Manager, OST Server publishes them both to Test-bed and to the user. Trial Manager not only manages the trial and user but also prepares environment to obtain information that are needed. He is responsible for projecting questions and question types. Contents of questions and number of them are optional, only the form is imposed.

When Test-bed sends package with data about events and time, OST Server notifies Trial Manager and users about new event.
OST Server reacts on triggers and matches proper set of questions, which are sent to Trial Manger and then published to Observer. 
When Observer sends his Observations, Trial Manager collects obtained data and has displayed reports about them and if he needs it he can generate it in CSV. 

Questions have different purposes, which are indicated in Observation Types. Great advantage of it is getting better criteria of comparison. Database with observations is more varied but it also connects categories, so analysing is more efficient. Correctly prepared questions and labels lead to most efficient results and better conclusion. Questions can have also different answer type such as slider, checkboxes, radio buttons and text field. With sending Observation user can also add some extra material such as additional description, voice record, picture or location. Each observation refers to participant and enables change of time.
 

|   | **Observer Support Tool (OST)** |
| ---- |:---- |
| **Short description** | The aim of OST is to collect observations, inform observers about trial progress, and visualize collected data|
| **Who will use it** | Trial Manager (person who configures the OST up front of a Trial, manages Observers and has overall control over the system). User, which can be an Observer or Participant |
| **Main functions** | Allowing trial managers to setup observation questions and send messages to observers|
|  | Assigning observers to specific observation tasks|
|  | Allowing observers to enter observations|
|  | Allowing trial managers to monitor observations, also in real–time|
|  | Allowing participants to complete surveys|
|  | Storing observations and surveys, and offers means to analyse the data|
| **Functions it does not do** | OST does not provide sets of data about events and time. This tool waits for simulation phases from external system,  publish events and generate questions based on these data. |
| **Links with other components** | OST is linked with Test-bed, which is responsible for providing simulation phases – data about events and simulation time. Package of data is sent to OST Server, events and set of questions are generated. When the new event is displayed, OST Server notifies the user and set of questions changes. |
| **(Technical) conditions** | Observer Support Tool (Mobile):<br>- Web browser<br>- Android (tablet and smartphone)<br>- iOS (tablet and smartphone)<br><br>Observer Management Tool (Desktop):<br>- Web browser |
| **Reference to repository/details** | [https://github.com/DRIVER-EU/ost](https://github.com/DRIVER-EU/ost) or [specifications](https://driver-eu.gitbooks.io/specification-of-the-online-observer-support-tool) |

## Name of Test-bed component

_This paragraph is to document the functional specifications on max 2 pages (A4) of a specific component. Please fill out the table below first before adding extra information you find relevant for the over-all functional specifications document D923.11._

_Remove this text when you have completed your paragraph._

_Add max 3 lines of introduction text here_

|   | **Test-bed component** |
| ---- |:---- |
| **Short description** | MAX 5 LINES, EXCL SPECIFIC FUNCTIONS AND USERS |
| **Who will use it** | LIST OF DIFFERENT TYPES OF USERS |
| **Main functions** | LIST OF MAIN FUNCTIONS AND WHICH NEED EACH FUNCTION FULFILLS |
| **Functions it does not do** | LIST OF SPECIFIC THINGS THIS COMPONENT IS NOT INTENDED FOR |
| **Links with other components** | LIST OF ALL OTHER COMPONENTS IT IS LINKED TO, INCLUDING THE DIRECTION OF THE LINK |
| **(Technical) conditions** | LIST OF TECHNICAL REQUIREMENTS / BOUNDARY CONDITIONS |
| **Reference to repository/details** | HYPERLINK TO COMPONENT&#39;S OWN GITBOOK/COW-REPORT |

### Extra notes

_If needed you can add extra information about your component here. This paragraph can be left empty, if the table above states all relevant information. Please note that more detailed information such as detailed technical requirements, development considerations and such are to be reserved for the component’s specific documentation (can be another GitBook or can be another report/deliverable on the COW)._

_Remove this text when you have completed your paragraph._

