# 4.   Aims of the Test-bed in DRIVER+ & high-over Functional Design

This chapter first gives the overall aims of the Test-bed in relation to the objectives of DRIVER+ as a whole. It describes the environment in which the Test-bed should functions and thereby the high-level functional design of the Test-bed. In the last, fourth paragraph the different types of users actively operating \(i.e. using\) the Test-bed are described and a high-level use-case for each use-mode.

## 4.1   What the Test-bed should provide

The first stated objective of DRIVER+ is to _“Develop a pan-European Test-bed for Crisis Management capability development \(…\)”._ In more detail:

* This Test-bed to-be-developed should specifically provide “\(…\) an infrastructure to create relevant environments, for enabling the trialling of new solutions and to explore and share CM capabilities\(…\)”,
* Because this Test-bed is used to “Run trials in order to assess the value of solutions addressing specific needs using guidance and infrastructure.”

So the entire Test-bed is supportive to test Solutions in a realistic, controlled and safe manner. Furthermore the Test-bed should not be a one-time implementation, but can be implemented within multiple organizations, both during the project, but also after the project and at organizations not being a project-partner.

Based on these DRIVER+ objectives and the lessons learned from the old DRIVER, the following high-level guidelines and requirements are set. Note that this lists consists of both real requirements \(i.e. must do's\) and wishes \(i.e. should/could do\).

1. **A realistic Platform to trial Solutions**  
   The Test-bed must be able to be implemented at a space - called Platform – in which Trials can be conducted in a realistic CM setting, in a controlled manner, in safety and not intervening with other \(real CM\) operations. This Platform is a physical and digital work-space for both the Participants \(i.e. the CM practitioners using the Solutions during the execution-phase of the Trial\) and the Trial staff \(i.e. all other people involved during the preparation-phase, execution-phase and evaluation-phase of the Trial\).

2. **Test-bed is used fitting the Guidance Methodology**  
   The Trial Staff will conduct Trials using this Test-bed following the Trial Guidance Methodology. This chapter first gives the overall aims of the Test-bed in relation to the objectives of DRIVER+ as a whole. It describes the environment in which the Test-bed must functions and thereby the high-level functional design of the Test-bed. In the last, fourth paragraph the different types of users actively operating \(i.e. using\) the Tes-bed are described and a high-level use-case for each use-mode. ce Methodology and will receive support and training, such that each Trial is set-up, executed and evaluated optimally by the Trial Staff.

3. **Connect Solutions with each other**  
   The \(mainly digital\) infrastructure of the Test-bed must make it possible to connect the Solutions to trial with each other, such that they can be controlled, can exchange data with each other and can be fed with simulated data.

4. **Connect Simulators to provide information of a fictive crisis**  
   The infrastructure of the Test-bed must also provide one or more simulated incidents/crises, because trialling Solutions during a real incident is both from an ethical and a practical perspective impossible. These simulated incidents - which can be completely virtual and computer-based, completely staged outdoors or a combination of the two - are to provide simulated data to the Solutions via the Test-bed’s infrastructure and are to provide information flows about the fictive incident\(s\) to the Participants \(i.e. information flows not being presented via the Solutions, for instance for incident commanders being present at a fictive incident scene an eye-level view on that scene\).

5. **Interface to control the Trial**  
   The Test-bed’s infrastructure must provide an interface to the Trial Staff – specifically the Operators controlling the Test-bed’s components – to create fictive incidents and to control how this fictive incident changes during the Trial’s execution-phase and to control the availability of and the data to/from the Solutions during this execution-phase.

6. **Interface to make observations**  
   The Test-bed’s infrastructure must provide functionality for the Trial Staff to save observations, recordings and data-logs coming both from the Solutions and from the simulated incidents. During the evaluation-phase, these observations, recordings and data-logs are to be combined to support the creation of an evidence-based evaluation report of the Trial.

7. **Open source Test-bed**  
   Crisis management affects us all, and therefore the Test-bed should achieve a broad adaptation and no hindrances with respect to license management. In addition, being open source, all developers from whatever organisation are welcomed to create pull requests to improve the Test-bed’s components.

8. **Open for commercial organisations**  
   Commercial organisations can help to integrate the Test-bed in an organisation, offer software solutions that exceed the capabilities of the originally offered components, or provide support in maintaining Test-bed components. The development and maintenance approach, while components are delivered in the project open source, should not exclude these commercial organisations.

9. **Standardized connections/interfaces**  
   The Test-bed’s infrastructure, specifically the software’s data exchange interfaces, must be standardized as much as possible to ease up connection and joint use of many different Solutions and Simulators, both from within the project and external ones.

10. **Modularized test-bed in several components**  
    The Test-bed’s infrastructure must be modularized and can be implemented partly and completely, such that it can be used efficiently and effectively during all development-, testing-, preparation-, execution- and evaluation-phases, by Trial-owners, Solution-providers, Simulator-providers and other Test-bed development parties.

11. **Provide data-sets for development and testing**  
    Specifically for developers who link up Solutions and Simulators to the Test-bed and for Trial Staff involved in scenario creation, the Test-bed must provide functionality to easily obtain \(simulated\) data and component’s inputs/outputs without the need that for every development step/test the entire Test-bed with all of its components must be activated, as this would require a too high overload on applications, computer hardware and manpower to perform even a simple test.

12. **The test-bed shall run in a **[**Docker**](https://www.gitbook.com/book/driver-eu/test-bed-specification/edit)** environment**  
    Installing software can be tedious, and due to its nature, the Test-bed consists of an integration of many tools. And although you could install each tool separately, in order to facilitate an easy deployment, Docker images and Docker compose will be used to rollout the Test-bed. Docker images are ready-to-use installer applications to install a specific software component on a computer. Docker compose provides a process to combine multiple Docker images together, such that can all be installed within one process, resulting in little manpower needed to implement any combination of Test-bed components. As Docker is supported on Unix as well as Windows operating systems, many different organisations should be able to run it smoothly.

    As a consequence, for the moment most of the supplied tools will run in a Unix environment, since Windows-based Docker containers are still experimental. However, this will not limit developers to create Windows-only solutions, as it can still connect to the Test-bed.

13. **The core of the test-bed is based on Apache Kafka**  
    In order to integrate different tools within the Test-bed, and to make it easy to connect them with other solutions, Apache Kafka is selected as base integration platform. And Kafka will be the only integration platform used. Although there are many good open-source messaging systems available, Kafka has a number of distinct advantages:

    * It is supported by the Apache organisation, and used actively by a number of major commercial organisations. This means that it will not go away quickly, and it has many client connectors to ease integration.
    * It is simple to setup and run, and performs very well. Where similar software systems cannot deal with more than 10.000 messages per second, Kafka can process a tenfold.

    Although there are other environments that could satisfy the D+ needs, this current reference implementation relies on Kafka, because the Test-bed should be a good reference implementation leveraging the efforts of the Kafka community. Being more generic \(i.e. supporting multiple back-ends\) would require a lot more development work, as well as not being able to leverage the particular strengths of the backend.

14. **Linked to the Training Module**  
    And finally, the Trial Guidance Methodology \(TGM\), the tools to use this methodology and the Test-bed must be accompanied by a Training Module, primarily aimed at people organizing Trials \(i.e. the Trial Staff\) explaining how to use the TGM and all of the Test-bed’s components best.

## 4.2   The environment the Test-bed is used in

![Test-bed environment](img/test-bed-environment.jpg) _Figure 4.1: The Test-bed in its environment_

The Test-bed is not just a stand-alone collection of software applications. It is used within a larger environment of DRIVER+ entities, as visualized in figure 4.1.

* **Participants** are using the **Solutions** to solve a fictive crisis. Solutions are any type of tool/product \(e.g. a software package, a training method or a new standard operating procedure\) that is intended to support/improve Crisis Management.  
* This fictive crisis exists in a virtual world and is thus a “virtual crisis”. This virtual crisis is created by a set of Simulators \(this can be computer-based **Simulators** to simulate a crisis within a virtual reality world, but a fire brigade’s physical exercise terrain is also a type of Simulator to stage a physical yet fictive incident, and it is also possible to use a combination of both\).
* Both Solutions and Simulators are connected to the **Test-bed**. The Test-bed’s core makes it possible to connect the Solutions with each-other and feed them with data coming from, or flowing to the Simulators. The functionalities of each component of the Test-Bed are explained in the next paragraph.
* The **Trial Staff** uses the Test-bed to:
  * Prepare the Trial – so to build the scenario, set-up and test all Solutions to be trialled, and set-up and test the Simulators to support this.
  * Run the Trial – so to control how the virtual crisis scenario evolves, observe the Participants and gather data-logs from both the Solutions and the virtual crisis present in the Simulators.
  * Evaluate the Trial – so to gather and analyse all observations, recordings and data-logs, and base an evidence-based evaluation report on these.
* The Trial Staff is supported - during all phases, but particularly in the preparation-phase - by the **Trial Guidance Methodology**. The **Guidance Tool** supports the Trial Staff by leading them step-by-step through all phases of the Trial, thereby assuring that the Trial Guidance Methodology is followed correctly and lessons learned are used most effectively, which results in a filled in Trial Action Plan \(i.e. an elaborate document about how the Trial is set-up, how it is to be run and what to evaluate\).  The **Training** Module provides the Trial Staff with training on this Trial Guidance Methodology, on using the Guidance Tool and on how to implement and use all components of the Test-bed best.
* The **Platform** provides the physical space \(i.e. one or more locations\) and hardware to run the Trial \(e.g. a simulation centre like available in The Hague, but this can also be a live exercise terrain\). So the Test-bed, Solutions and Simulators are available there, it provides rooms/areas for Participants to execute CM operations with the Solutions as they would do in real-life crises and provides rooms/areas for Trial Staff to operate the Test-Bed and Simulators, thereby controlling how the Trial runs. The Platform is also used in the preparation phase, by installing and testing all \(software\) components needed during the running of the Trial and for evaluation of the Trial.

## 4.3   High-level functional design

![Test-bed design](img/test-bed-design.jpg) _Figure 4.2: All components of the Test-bed_

Zooming in on the Test-Bed, as shown in figure 4.2, the following components can be distinguished:

* The **Common Information Space \(CIS\)**, located in the central software connection bus, provides an interface to connect the Solutions to the Test-bed. These connections are made by using the standardized CIS Adapters.

* The **Common Simulation Space \(CSS\)**, provides a similar connection bus to connect the Simulators to the Test-bed. These connections are made by using the standardized CSS Adapters.

* Because the type of data-connections and the required data-exchange speed differs for Solutions on one side \(i.e. report-like messages with a lower update speed\) and Simulators on the other side \(i.e. item oriented data with high update speed\), the CIS and CSS are split. They are connected via one or more **Gateways**. Gateways are used CSS - CIS to feed Solutions with data from the simulated crisis \(e.g. positions of virtual police cars driving around in the fictive region\) and CIS - CSS to pass through changes inputted via one or more Solutions to the Simulators \(e.g. a command police to block off an area, resulting in several police cars driving to the edges of that area and setting up road blocks there\).  
  A **Validation Service** can be added to safeguard messages sent CSS&lt;-&gt;CIS are correctly filled and understandable by the counterpart.

* Both the CIS and the CSS are controlled via the **Test-bed Admin Tool**. This provides an interface for Trial Staff to control which Solutions and Simulators are to be started and which data is \(not\) exchanged.

* The **Trial Scenario Manager** and the **Time Service** components provide functionality and an interface for Trial Staff to:

  * In the preparation-phase: create a high-over timeline of the Trial Scenario with Injects of changes to the virtual crisis which can be activated during the execution-phase \(note that it is far from necessary that all injects are activated and that this time-line in most cases has a branched structure of all things foreseen that could happen during managing the virtual crisis\).
  * In the execution-phase: activate the needed Injects based on decisions \(not\) taken by the Participants, the use by them of the Solutions and/or specific detailed storylines to be activated to trigger specific use-cases of one or more Solutions. These Injects then trigger prepared changes in the Test-bed manager \(e.g. simulate failure of internet leading to Solutions not receiving data from Simulators anymore\), in the CIS or Solutions directly \(e.g. new message of role-played stakeholder\) and mostly in one or more Simulators \(e.g. wildfire expands on the West flank\).
  * In the execution-phase: influence the fictive time clock, meaning starting the Trial \(i.e. play the time from a fictive point in time, for example a fictive climate summit in October 2020\), influencing the speed of time of the fictive clock \(e.g. speeding up time to go through CM operations quicker than in reality or slowing it down to focus on specific moments during CM operations\), pausing the fictive clock \(e.g. for a coffee break or a time-out for extra explanations\), jumping back in fictive time \(e.g. re-doing a specific CM operation\) and stopping the fictive time \(i.e. ending the Trial\)

* The **Observer Support Tool** provides a module to prepare, make and gather observations:

  * In the preparation-phase: the Observation Manager \(i.e. person within the Trial Staff\) can manage who can observe who and create observation templates dedicated on what is to be observed. Ethical considerations regarding the formulation of observation templates and storage of data is to be taken into account during this phase.
  * In the execution-phase: Observers \(i.e. one or multiple persons within the Trial Staff\) can create observations based on prepared observation templates.
  * In the execution-phase: all observations are gathered and the Observer Manager sees them incoming and can guide the Observers by extra Observation Templates and sending them messages.

* The **After Action Review \(AAR\)** module gathers in execution-phase the data-logs and \(screen-\) recordings coming via the CIS from the Solutions and via the CSS from the Simulators and gathers the Observations coming from the Observation Support Tool. In the evaluation-phase these data-logs, recordings and observations can be reviewed.

* For development and implementation purposes, the Test-Bed also contains:

  * A **Message Injector** to input specific, single messages during development to test whether these messages are correctly received by another component \(e.g. a fire alert message which is to be produced by a Simulator is correctly received by a Solution\).
  * A **Play Service** to input several messages in chronological order, to test that without the Trial Scenario Manager and Simulators fully up and running these messages are correctly received by the Solutions or vice versa.
  * **Data Server\(s\)** to feed the Simulators and potentially also the Solutions with geo-specific information \(e.g. the region The Hague, all of its fire stations and all fire truck usually present there; or a full digital map with GIS-data of Vienna\)
  * A **Docker Environment** providing images \(e.g. installers\) of each component, such that the installation of a limited Test-Bed configuration at a Solution owner and installation of the entire Test-bed at a Trial owner’s simulation centre can be done quickly and transparently.

The next chapter \(ADD CHAPTER HYPERLINK\) provides summarized overviews per component, including a hyperlink to that component’s separate detailed specifications document.

## 4.4   User-types and high-level use-cases

The following high-level use-cases describe the workings of the complete Test-bed during the different phases of use. Note that developing and updating the Test-bed’s components is left out of these phases of use. The use-cases are focused on how users operate components of the Test-bed. This section is intended to describe the coherent use of the complete Test-bed and to further explain the functional design of the Test-bed. This section is not intended to detail each specific component. Therefore, the steps in the use-cases are described only on a very high-over level.

### 4.4.1   Use-modes

The Test-bed is used throughout 3 phases and next to that in Development-mode \(i.e. use-modes of the Test-bed\).

Table 4.1: Use-modes of the Test-bed

| **Use-mode** | **Description** |
| --- | --- |
| **Preparation phase** | In which all Solutions and Simulators are connected to the Test-bed, the Scenario is built and the entire set-up is tested to assure a good run of the Trial. |
| **Execution phase** | In which one or more sessions are run in with Participants use the Solutions according to the evolving Scenario. |
| **Evaluation phase** | In which the Trial’s sessions are analysed and conclusions are drawn about the usefulness of the Solutions and the way the Trial was executed. |
| **Development mode** | In which the Test-bed’s components are developed or a Solution or Simulator is connected to the Test-bed. |

### 4.4.2   User-types

Throughout all use-modes, the following user-types can be distinguished. Note that 1 member of a Trial Committee \(i.e. the group of people principally responsible for setting-up, running and evaluating a Trial\) can take up the roles of several user-types \(e.g. 1 person being a Trial Scenario Builder and the Trial Director and one of the Trial Evaluators\). Also note that the entire set of roles to be included in the preparation and execution of a Trial \(as listed in the Trial Action Plan template\) is longer than the list provided in this paragraph. This paragraph focusses the user-types only on those roles actively using one or more components of the Test-Bed.

Table 4.2: User-types of the Test-bed

| **User-type** | **Description** |
| --- | --- |
| **Participants** | Persons \(usually CM practitioners\) actively using the Solutions and performing CM-operations based on which information they receive from the Solutions and directly from the Simulators about the fictive crisis. |
| **Trial Scenario Builders** | Persons from the Trial Staff who are configuring the Trial Scenario in the Test-bed's components \(i.e. Trial Scenario Manager, Simulators, Observation Support Tool, Test-bed Admin Tool and potentially also by configuring Solutions\). |
| **Trial Director** | The single leader of the Trial Staff \(i.e. 1 person\) being in in the execution phase charge of how the Trial and its Scenario evolves during the session\(s\). |
| **Operators** | Persons from the Trial Staff who are operating the Test-bed's components during the execution of the session\(s\), with a primary focus on the Trial Scenario Manager \(i.e. how the Scenario evolves\), the Test-bed Admin Tool \(i.e. whether everything is working correctly and controlling information flow to/from Solutions and Simulators\) and directly in the Simulators \(i.e. how the Scenario evolves\). |
| **Role-players** | Persons from the Trial Staff who are supporting the Operators by providing role-play towards the Participants, thereby simulating stakeholders not present \(e.g. performing phone-calls as minister or King of the Netherlands\). |
| **Observer Manager** | Person of the Trial Staff \(i.e. usually 1 person, but can be multiple\) to operates the Observer Support Tool both in the preparation phase \(configuring the tool for a specific Trial\) and in the execution phase \(i.e. managing the Observers\). |
| **Observers** | Persons who take observations during the Trial’s session\(s\) by using the Observation Support Tool. Observers belong to the Trial Staff, independent whether they are employed by D+ internal organisations or externals. |
| **Trial Evaluators** | Persons from the Trial Staff who analyse the Trial's session\(s\) during the evaluation phase, using the After Action Review component. |
| **Implementers** | Technical support staff who install and test the one or more of the Test-bed's components at a Platform location. |
| **Solution Owner** | An organisation who has developed a Solution which is to be trialled using the Test-bed. For this, technical developers of that organisation have to link their Solution with the Test-bed via a CIS Adapter, thereby using \(a sub-set of\) the Test-bed's components, including the extra developer components. |
| **Simulator Owner** | An organisation who has developed a Simulator which is used during a Trial to provide information from a fictive crisis. For this, technical developers of that organisation have to link their Simulator with the Test-bed via a CSS Adapter, thereby using \(not all\) Test-bed's components, including the extra developer components. |
| **Test-bed Component Developers** | Persons working within the organisations creating the Test-bed's components. These developers also use other components of the Test-bed to develop and test their own component. |

### 4.4.3   High-level use-case: Set-up and testing of the Test-bed

_This use-case is executed at every location where the Test-bed is \(partly\) installed or updated, so before the Trial's preparation phase starts._

1. Implementer, using the Docker Environment, creates a full installer of all components to install.
2. Implementer installs this installer on the hardware available at the Platform location.
3. Implementer also sets-up/installs the Solutions and Simulators needed for a Trial.
4. Implementer tests whether the installation was successful.
5. If issues come to light during these tests: Implementer contacts the applicable Component Developers, Solution Owners and/or Simulator Owners

_These steps are repeated until the installation of all components, Solutions and Simulators is successful, such that the Trial can be prepared and run._

### 4.4.4   High-level use-case: Starting-up the Test-bed

_This use-case is executed at the start of every use-mode of the Test-bed._

1. Operator or Implementer starts up the Test-bed Admin Tool, the Trial Scenario Manager and the Solution\(s\) and Simulator\(s\) that require a manual start-up
2. Operator or Implementer selects the applicable Scenario, which starts up the other required components
3. Operator or Implementer checks correctness of start-up of all needed components via the Test-bed Admin Tool
4. Operator or Implementer restarts components and/or reloads Scenario if some start-ups were unsuccessful.

### 4.4.5   High-level use-case: Scenario creation

_This use-case is executed in the preparation phase of each Trial._

1. Scenario Builders follow the Guidance Methodology using the Guidance Tool to come up with a detailed Trial Action Plan about what to trial, how to trial and what the Scenario will be.
2. Scenario Builders configures the components and selected Solution\(s\) and Simulator\(s\) according to the TAP.
3. Scenario Builders select data set\(s\) from the Data Server\(s\) to populate the Solution\(s\) and Simulator\(s\)
4. Scenario Builders enter the Scenario's timeline\(s\) in the Trial Scenario Manager
5. Scenario Builders set a fictive start-time in the Time Service
6. Scenario Builders set up a fictive, virtual crisis inside the Simulator\(s\) and prepare the injects in these Simulators that could occur
7. Scenario Builders configure the possible data exchanges between CIS and CSS by setting up the Gateways and the Test-bed Admin Tool
8. The Observation Manager configures observer roles and observation templates in the Observer Support Tool.
9. Scenario Builders, Observer Manager and future Operators and Trial Director run one or more test-sessions to check the entire Scenario and make adjustments if needed.

_The last step is repeated until all involved feel comfortable with the set-up and Scenario to run successful Trial sessions._

### 4.4.6   High-level use-case: Training \(extra\) Trial Staff and Participants

_This use-case is executed just before the execution phase of each Trial._

1. Scenario Builders and the Trial Director \(and potentially Simulator Owners\) instruct Operators new to the Trial and its Scenario about the Trial Scenario, what can be adjusted during the Trial execution, under which conditions and how.
2. Scenario Builders, the Trial Director and Operators instruct Operators new to the Trial about the Trial Scenario and which injects can be role-played and how.
3. Observation Manager instructs the Observers about the Trial Scenario and what is to be observed by whom and how to use the Observer Support Tool and the prepared observation templates.
4. Scenario Builders and/or Solution Owners instruct Participants about how to use the Solutions
5. Scenario Builders and/or Simulator Owners instruct Participants about how to use the applicable Simulator interfaces
6. Trial Director gives a briefing to all Participants and Trial Staff about the upcoming session.

### 4.4.7   High-level use-case: Running a Trial session

_This use-case is the execution phase of each Trial, focussed on a single session \(i.e. 1 time a Scenario is run\)._

1. All Participants and Trial Staff take position at their respective locations
2. Trial Director, with help of Operators and Observers, checks readiness of all Participants and Trial Staff
3. Trial Director gives to go to start session
4. Operator starts the running of the fictive time in the Time Service and thereby the evolution of the Scenario in the Trial Scenario Manager
5. Participants acquire information about the fictive crisis via the Solutions and Simulators
6. Participants use the Solutions as much as possible as they would do during a real crisis and take decision accordingly
7. Observers gather observations following the observation templates in the Observer Support Tool and the Observer Managers sees these coming in and directs the Observers
8. Operators and Role-players activate injects based on the decisions taken by Participants, the Scenario time-line\(s\), cases to trial the Solutions on, observations received and over-all directions by the Trial Director
9. When all applicable Scenario time-lines and cases to trial the Solutions on are activated, or the Trial session has diverted too much from the Scenario, the Trial Director decides to stop the session
10. The Operator stops the Scenario and fictive time progression via the Trial Scenario Manager and Time Service.
11. The Operators use the After Action Review component to gather and save relevant data-logs, recordings and observations of that session.
12. Observers or Evaluators might question the Participants, if the evaluation process states so.

_In case of an error or crash during a session, these steps can be repeated to start a new session from the point before the error/rash occurred._

_These steps can also be repeated from a point half-way the same Scenario to trial the Solutions under the conditions if another decision was taken and thus other Scenario time-lines were followed._

_One can also load another Scenario and repeat the steps above, thereby creating a new session and trialling the Solutions under completely other conditions._

### 4.4.8   High-level use-case: Evaluating a Trial

_This use-case is the evaluation phase of each Trial.  _

1. Evaluators view the data-logs, recordings and observations from a single session, using the After Action review component.
2. Evaluators analyse the combination of data-logs, recordings and observations from one or multiple sessions to research how exactly the Solutions were used, how these Solutions performed under certain circumstances and how the Participants reacted under these circumstances.
3. Evaluators can contact Solution Owners or even Simulator Owners to extract more information from specific data-logs and recordings.
4. Evaluators can contact Participants to gather more information about specific moments during a session.
5. Evaluators draw conclusions about these analyses into the usefulness of the Solutions, the way the Trial was set-up and executed and refer back to the Trial's objectives. All this is documented in the Trial's evaluation report.

### 4.4.9   High-level use-case: Developing the Test-bed's components

_This use-case is executed in Development mode, up front of \(i.e. initial development\) and parallel to \(i.e. component updates\) the set-up, execution and evaluation of the Trials._

1. Developers draw out a functional and technical design of a component and the test-cases, taking into account the specifications of the other components their own component is linked to.
2. Developers develop the component and, if needed, adjust the functional or technical or test-case design.
3. If needed, developers contact developers of other components to adjust the specifications.
4. Developers test their own component stand-alone and in combination of the other components it is linked to.
5. Developers create a docker image of their component and upload it together with documentation to the Docker Environment.

### 4.4.10   High-level use-case: Developing the connection of a Solution/Simulator

_This use-case is executed in Development mode, up front of the execution and evaluation of the Trials, and for bug-fixing during the preparation phase of a Trial._

1. Solution/Simulator Owner is being trained/instructed about the aims of the Test-bed, the available CIS/CSS Adapters and how to use and not use them.
2. Solution/Simulator Owner selects the most applicable CIS/CSS Adapter and develops this into a Solution/Simulator specific adapter.
3. Solution/Simulator Owner implements the Test-bed components needed to test its own Solution/Simulator and the specific adapter created
4. Solution/Simulator Owner tests its developed Solution/Simulator and the specific adapter and adjusts it if needed.



