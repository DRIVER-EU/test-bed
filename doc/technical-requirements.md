# Summarized description per Test-bed component

This chapter contains for each component an overview of what it is aimed at, who uses it and in which phase of the Trial it is used, in the form of a table per component. The table also contains a hyperlink to the detailed specification of this component.

## Common Information Space (CIS) {#cis}

The Common Information Space (CIS) describes the concept of information exchange between solutions that are connected to the test-bed. Also, information provided by simulations are forwarded and distributed to the solutions via the CIS, and vice versa, messages sent from the CIS are transmitted to the CSS.

|   | **Common Information Space** |
| ---- |:---- |
| **Short description** | The Common Information Space (CIS) describes the concept of information exchange between tools that are connected to the test-bed.  Also, information provided by simulations are forwarded and distributed to the tools via the CIS. |
| **Who will use it** | Directly:<br>- Developers<br>Indirectly<br>- Everyone using a solution connected to the test-bed |
| **Main functions** | The CIS will account for:<br>- Connecting the tools to the test-bed via CIS adapters<br>- Distribution of messages<br>- Security regarding access rights (They have not been defined)|
| **Functions it does not do** | The CIS will NOT account for: <br>- Validation of messages |
| **Links with other components** |- Admin tool – to configure (parts of) the CIS<br>- AAR – re-uses messages sent via the CIS<br>- CIS-CSS Gateways – data exchange between CIS and CSS in both directions<br>- Validation Service – messages coming from the CSS to the CIS are syntax validated|
| **(Technical) conditions** | Apache Kafka is needed |
| **Reference to repository/details** |  |

**NOTE**

The CIS itself is visible only to developers, not end-users. However, end-users may configure the CIS (or parts of it) to a certain extend using the Admin tool described in ADD_LINK.

## Common Simulation Space (CSS) {#css}

The Common Simulation Space (CSS) describes the concept of information exchange between simulators that are connected to the test-bed. Also, information provided by simulations are forwarded and distributed to the solutions via the CIS, and vice versa, messages sent from the CIS are transmitted to the CSS.

|   | **Common Simulation Space** |
| ---- |:---- |
| **Short description** | The Common Simulation Space (CSS) describes the concept of information exchange between Simulators that are connected to the Test-Bed. These Simulators jointly generate and maintain a simulation world needed for providing a ground truth of the fictive crisis, feed the Solutions with fictive data via the CIS – and vice versa – receive messages sent from the CIS, and the deliver to the participants a good enough image of the fictive crisis for them to be assessed. |
| **Who will use it** | Implementers, Solution Owner, Simulator Owner, Test-bed Component Developers |
| **Main functions** | The CSS will connect the simulators to each other and link to the gateways to exchange data CIS<->CSS |
| **Functions it does not do** | Deal with security: simulators don't have secrets.   |
| **Links with other components** | Admin tool for configuration of the CSS; CIS-CSS gateways; perhaps also the [AAR](#aar) in case we want to use the data for analysis|
| **(Technical) conditions** | Apache Kafka is needed |
| **Reference to repository/details** |  |

## CIS-CSS gateways {#cis-css-gateways}

The CSS-CIS gateways are the interface between the Common Simulations Space (CSS) and the Common Information Space (CIS). Data from the simulations is translated into data that can be understood by the tools connected to the CIS and vice-versa. Since they translate specific message types, there may be many of them.

|   | **CIS-CSS gateways** |
| ---- |:---- |
| **Short description** | The CSS-CIS gateways are the interface between the Common Simulations Space (CSS) and the Common Information Space (CIS). Data from the simulations is translated into data that can be understood by the tools connected to the CIS and vice-versa. |
| **Who will use it** | Developers |
| **Main functions** | The CSS-CIS gateways will account for:<br>- Aggregating messages coming from the CSS<br>- Translating between CSS topics and CIS topics |
| **Functions it does not do** | The CSS-CIS gateways will NOT account for: Semantic translation |
| **Links with other components** | - [CIS](#cis) & [CSS](#css): the gateways are the bridge between them<br>Validation service: the validation service is a gateway service that validates messages going through the gateway |
| **(Technical) conditions** | Must run in a Docker environment |
| **Reference to repository/details** |  |

## Test-bed manager (Admin tool) {#admin-tool}

The admin tool can be used to configure parts of the test-bed, e.g. which tools are connected to each other (via the topics). Also, it provides test-bed information (i.e. existing topics) as well as status information (heartbeat, configuration, logging) of the connected tools. Furthermore, it is the main interface to the security services.

|   | **Test-bed manager (Admin tool)** |
| ---- |:---- |
| **Short description** |The admin tool can be used to configure parts of the test-bed, e.g. which tools are connected to each other (via the topics). Also, it provides test-bed information (i.e. existing topics) as well as status information (heartbeat, configuration, logging) of the connected tools. Furthermore, it is the main interface to the security services.|
| **Who will use it** | Trial manager |
| **Main functions** | The Admin tool will account for:<br>- An interface to configure the CSS-CIS gateways<br>- An interface to configure the adapters<br>- Loading the KAFKA topic configurations<br>- Providing a Watch dog |
| **Functions it does not do** | The Admin tool will NOT account for:<br>- Setting up topics after initialization<br>- Modifying topics after initialization |
| **Links with other components** | - [CIS-CSS gateways](#cis-css-gateways) and adapters: they are configured using the admin tool |
| **(Technical) conditions** | Must run in a docker environment |
| **Reference to repository/details** | [GitHub repository](https://github.com/DRIVER-EU/test-bed-admin) |

## Scenario Manager {#sm}

The scenario manager can be used to create scenarios (master event lists) that are injected, via the test-bed, into.
For example, it injects a message to start a flooding, to send out emails to participants, or to instruct a role-player to perform an act. Naturally, it can also control the time, and (re-)start/pause/stop a scenario.

|   | **Scenario Manager** |
| ---- |:---- |
| **Short description** |  |
| **Who will use it** | Trial manager, scenario writers |
| **Main functions** | Publish messages, often intended for simulators, but can also be used to directly show a message inside a solution. |
| **Functions it does not do** | Record messages |
| **Links with other components** | Can be used to send messages to simulators, but also to solutions, via the adapter. It's strongest connection is with the [time service](#time-service) in order to control the fictive scenario time.|
| **(Technical) conditions** | Must run in a docker environment |
| **Reference to repository/details** | [GitHub repository](https://github.com/DRIVER-EU/scenario-editor) |

## Validation Service {#validation-service}

The message validation service serves the purpose of validating the syntax of messages to match a certain standard. Only successfully validated messages are distributed further into the system. It is an extra step with respect to the default validation that is carried out by all adapters, and mainly required when testing new solutions or during a dry-run.

|   | **Validation Service** |
| ---- |:---- |
| **Short description** | The message validation service serves the purpose of validating the syntax of messages to match a certain standard. Only successfully validated messages are distributed further inside the system.  |
| **Who will use it** | It is internally used by the adapters, and configured via the [Admin tool](#admin-tool) |
| **Main functions** | The validation service will account for:<br>- Checking if the syntax of the message fulfils a certain standard<br>- Listening to a specific TOPIC (e.g. validation-cap-topic). if it validates, the messages will be forwarded to the corresponding standard topic (e.g. cap-topic).<br>|
| **Functions it does not do** | The validation service will NOT account for: Semantic validation of messages |
| **Links with other components** | - [CIS-CSS gateways](#cis-css-gateways): the message validation is a gateway service<br>CIS: only messages that fulfil a certain standard are forwarded to the rest of the system |
| **(Technical) conditions** | Use of Apache AVRO schemas to represent standards |
| **Reference to repository/details** | HYPERLINK TO COMPONENT&#39;S OWN GITBOOK/COW-REPORT |

## Message Injector

The message injector is used for debugging purposes, similar to [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop), and it is used to inject messages manually into the test-bed in order to generate a certain response.

|   | **Message Injector** |
| ---- |:---- |
| **Short description** | The message injector is used for debugging purposes, similar to [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop), and it is used to inject messages manually into the test-bed in order to generate a certain response.|
| **Who will use it** | Developers |
| **Main functions** | The main functionality is to inject (prepared or on the fly) messages into the test-bed for testing purposes |
| **Functions it does not do** |  |
| **Links with other components** | It will use one of the existing adapters, most likely, the Java one, to send its messages to the test-bed |
| **(Technical) conditions** | Must run in a Docker enviroment |
| **Reference to repository/details** |  |

## Data services

The Data services is not a single service, but a group of non-essential, but very practical services to complement the test-bed. Their main purpose is to share data to enrich the trial, such as map data, height data, census layers, weather information, etc..

|   | **Data services** |
| ---- |:---- |
| **Short description** | The Data services is not a single service, but a group of non-essential, but very practical services to complement the test-bed. Their main purpose is to share data to enrich the trial, such as map data, height data, census layers, weather information, etc.. |
| **Who will use it** | Trial staff |
| **Main functions** | Share map data, height data, vector data |
| **Functions it does not do** | Create or edit this data |
| **Links with other components** | Can be used by solutions as well as simulators as a data backend |
| **(Technical) conditions** | Must run in a Docker environment |
| **Reference to repository/details** | [WMS service](https://github.com/DRIVER-EU/test-bed-wms-service), [MBtiles service](https://github.com/DRIVER-EU/test-bed-mbtiles-service) |

Related to these data services is the [AVRO schemas](https://github.com/DRIVER-EU/avro-schemas) repository, which contains all the schema's that have been used (so far).

## Docker-composer

All of the test-bed's core functionality run inside a Docker environment (*virtual machines*). The Docker-composer website allows you to select the test-bed components you actually need, and it creates a dedicated Docker-compose file for you. This file can be easily run (`docker-compose up -d`), and the test-bed is started using a single command, linking together services and data.

|   | **Docker-composer** |
| ---- |:---- |
| **Short description** | All of the test-bed's core functionality run inside a Docker environment (*virtual machines*). The Docker-composer website allows you to select the test-bed components you actually need, and it creates a dedicated Docker-compose file for you. |
| **Who will use it** | End users wishing to try out a solution, Developers and Sysops to setup the test-bed |
| **Main functions** | Tie many different Docker images together |
| **Functions it does not do** | Create a Docker image for you |
| **Links with other components** | All Dockerized services, including the Dockerized solutions available in the Portfolio of Solutions |
| **(Technical) conditions** | Must run in a Docker environment |
| **Reference to repository/details** | [Website](https://driver-eu.github.io/docker-composer), [GitHub repository](https://github.com/DRIVER-EU/docker-composer),  |


## Time service

The Time service is the single source of truth of the fictive time during a trial. It listens to the scenario manager in order to play/pause/stop a scenario, and it may speed up or slow down the simulation. Each adapter will subscribe to the time service, and offer its users the fictive time. When sending messages containing time information, each service should use this fictive time.

In addition, it shares the server's time using the Network Time Protocol (NTP), so all services in the test-bed can use it to sync their clocks.

|   | **Time service** |
| ---- |:---- |
| **Short description** | The Time service is the single source of truth of the fictive time during a trial. It listens to the scenario manager in order to play/pause/stop a scenario, and it may speed up or slow down the simulation. Each adapter will subscribe to the time service, and offer its users the fictive time. When sending messages containing time information, each service should use this fictive time. |
| **Who will use it** | It is an internal service |
| **Main functions** | Publish the fictive scenario time, play/pause/stop/speed up/slow down the time |
| **Functions it does not do** | |
| **Links with other components** | [Scenario manager](#sm) and all adapters |
| **(Technical) conditions** | Must run in a Docker environment |
| **Reference to repository/details** | [GitHub repository](https://github.com/DRIVER-EU/test-bed-time-service) |

## After-Action-Review (AAR) {#aar}

The After-Action Review (AAR) tool provides the possibility to collect data after a trial has finished and analyse it. Its main purpose is to facilitate the evaluation of the trialed solutions, and to help the participants determine how well they functioned. It collects messages (exchanged during trial), observation reports and takes screen-shots.

|   | **After-Action-Review** |
| ---- |:---- |
| **Short description** |The After-Action Review (AAR) tool provides the possibility to collect data after a trial has finished and analyse it. Its main purpose is to facilitate the evaluation of the trialed solutions, and to help the participants determine how well they functioned. It collects messages (exchanged during trial), observation reports and takes screen-shots.|
| **Who will use it** | Facilitator |
| **Main functions** | The AAR tool will account for:<br>- Storing relevant data <br>- Reviewing a trial completely or parts of it<br>- Jump to specific point in time |
| **Functions it does not do** | The AAR tool will NOT account for: Changing the course of the trial afterwards in any way |
| **Links with other components** | [CIS](#cis), [CSS](#css), [Scenario Manager](#sm), [Observer Support Tool](#ost): The AAR tool uses the messages exchanged inside the CIS, CSS, Scenario Manager, and the observations to provide the review capability.|
| **(Technical) conditions** | The Security Service may have to grant the access to all secured topics to the AAR backend service to give the service the possibility to collect the data.|
| **Reference to repository/details** | [GitHub repository](https://github.com/DRIVER-EU/test-bed-admin) |

## Play service {#play}

The Play service acts as a mini-scenario editor: it can either publish one recorded message, or play a sequence of recorded (timed) messages. Besides being useful for debugging, where a developer can replay a recorder scenario, it is also useful for testing solutions standalone, where the play service can play a simple scenario so the solution can shine.

The recorded messages can be obtained using [Landoop's Kafka Topics UI](https://github.com/Landoop/kafka-topics-ui/tree/master/docker), which allows you to download all messages in a topic to a single JSON file with key-value messages.

|   | **Play service** |
| ---- |:---- |
| **Short description** | The Play service acts as a mini-scenario editor: it can either publish one message, or play a sequence of (timed) messages. Besides being useful for debugging, where a developer can replay a recorder scenario, it is also useful for testing solutions standalone, where the play service can play a simple scenario so the solution can shine. |
| **Who will use it** | Developers; Participants; Solution owners/evaluators |
| **Main functions** | Publish a single recorded message, or a sequence of messages, to the test-bed |
| **Functions it does not do** | Create messages from scrap, or record messages |
| **Links with other components** | It is connected to the test-bed via an adapter, and it is related to the message injector |
| **(Technical) conditions** | Should run in a Docker environment, can get recorded messages from a mounted Docker volume |
| **Reference to repository/details** | [GitHub repository](https://github.com/DRIVER-EU/kafka-replay-service) |

Related to this service is the open source [csCOP](https://github.com/DRIVER-EU/csCOP) (Common Operational Picture) tool, which can be used as a COP during a trial, but which can also be used to test the messages published by simulators and solutions.

## Observer Support Tool {#ost}

The Observer Support Tool’s aim is to collect observations, inform observers about trial progress and visualize collected data. There are different perspective to look at this tool. Main user, who uses the mobile version of a tool to send his observations is called Observer. From the other side there exists Trial Manager, he focuses on collected data and analysing it on desktop. Each of them has their own functionalities provided by OST. There are also these functionalities which are connected with non-functional requirements.

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

## Security concept

|   | **Security** |
| ---- |:---- |
| **Short description** | MAX 5 LINES, EXCL SPECIFIC FUNCTIONS AND USERS |
| **Who will use it** | LIST OF DIFFERENT TYPES OF USERS |
| **Main functions** | LIST OF MAIN FUNCTIONS AND WHICH NEED EACH FUNCTION FULFILLS |
| **Functions it does not do** | LIST OF SPECIFIC THINGS THIS COMPONENT IS NOT INTENDED FOR |
| **Links with other components** | LIST OF ALL OTHER COMPONENTS IT IS LINKED TO, INCLUDING THE DIRECTION OF THE LINK |
| **(Technical) conditions** | LIST OF TECHNICAL REQUIREMENTS / BOUNDARY CONDITIONS |
| **Reference to repository/details** | HYPERLINK TO COMPONENT&#39;S OWN GITBOOK/COW-REPORT |

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

