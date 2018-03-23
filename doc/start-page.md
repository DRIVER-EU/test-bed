# D923.11 - Functional specifications of the DRIVER+ Test-bed

## About the DRIVER+ project

![DRIVER+](img/driver-home-page.jpg)

Current and future challenges due to increasingly severe consequences of natural disasters and terrorist threats require the development and uptake of innovative solutions that are addressing the operational needs of practitioners dealing with Crisis Management. DRIVER+ \(Driving Innovation in Crisis Management for European Resilience\) is a FP7 Crisis Management demonstration project aiming at improving the way capability development and innovation management is tackled. DRIVER+ has three main objectives:

1. Develop a pan-European Test-bed for Crisis Management capability development:

   * Develop a common guidance methodology and tool \(supporting trials and the gathering of lessons learned
   * Develop an infrastructure to create relevant environments, for enabling the trialing of new solutions and to explore and share CM capabilities
   * Run trials in order to assess the value of solutions addressing specific needs using guidance and infrastructure
   * Ensure the sustainability of the pan-European Test-bed

2. Develop a well-balanced comprehensive Portfolio of Crisis Management Solutions:

   * Facilitate the usage of the portfolio of solutions
   * Ensure the sustainability of the portfolio of tools

3. Facilitate a shared understanding of Crisis Management across Europe:

   * Establish a common background
   * Cooperate with external partners in joint trials
   * Disseminate project results

In order to achieve these objectives, five sub-projects \(SPs\) have been established. **SP91 Project Management** is devoted to consortium level project management, and it is also in charge of the alignment of DRIVER+ with external initiatives on crisis management for the benefit of DRIVER+ and its stakeholders. In DRIVER+, all activities related to SIA \(from the former SP8 and SP9\) are part of SP91 as well. **SP92 Testbed** will deliver a Guidance methodology and guidance tool supporting the design, conduct and analysis of trials and will develop a reference implementation of the test-bed. It will also create the scenario simulation capability to support execution of the Trials. **SP93 Solutions** will deliver the Portfolio of Solutions \(PoS\) which is a database driven web site that documents all the available DRIVER+ solutions, as well as solutions from external organisations. Adapting solutions to fit the needs addressed in trials, will be done in SP93. **SP94 Trials** will organize four series of trials as well as the final demo. **SP95 Impact, Engagement and Sustainability** is in charge of communication and dissemination, and also addresses issues related to improving sustainability, market aspects of solutions, and standardization.

The DRIVER+ trials and the Final Demonstration will benefit from the DRIVER+ Test-bed, providing the technological infrastructure, the necessary supporting methodology and adequate support tools to prepare, conduct and evaluate the trials. All results from the trails will be stored and made available in the Portfolio of Solutions, being a central platform to present innovative solutions from consortium partners and third parties and to share experiences and best practices with respect to their application. In order to enhance the current European cooperation framework within the Crisis Management domain and to facilitate a shared understanding of Crisis Management across Europe, DRIVER+ will carry out a wide range of activities, whose most important will be to build and structure a dedicated Community of Practice in Crisis Management \(CoPCM\), thereby connecting and fostering the exchange on lessons learnt and best practices between Crisis Management practitioners as well as technological solution providers.

## Executive Summary

This deliverable provides the requirements specifications – meaning both must-do requirements and should/could-do wishes - of the to-be-developed Test-bed within the DRIVER+ project \(D+\). This Test-bed consists of software components intended to support the execution of D+ Trials. Trials are performed to test Crisis Management Solutions \(i.e. any type of tool/product/procedure, like a software package, a training method or a new standard operating procedure, that is intended to support/improve Crisis Management\) for their pro’s and con’s in a realistic yet fictive incident/crisis setting. This deliverable is available as living document on the online, open-source document-sharing platform GitBook, such that it can be updated when development and use of the Test-bed progresses and to open up these specifications to anyone outside D+. This document describes what the Test-bed must/should be. How theserequirements and wishes are implemented is documented in Deliverables D923.21, D923.22 and D923.23 - Reference Implementations of versions 1/2/3.

![](/doc/img/process.png)

_Figure Sum-1: Iterative process followed for requirements and wishes specification_

The documented specifications are based on lessons learned from experiments done in the former DRIVER-project, use-case analysis, experiences from development partners is other project, market analysis into comparable components and consulting D+ Trial organizers and Solution providers. The specifications drafting process runs in parallel with the design and development process of the Test-bed’s components such that both processes can influence each other positively in a quick and agile manner.

The following lessons were learned from the use of previous test-beds in the former DRIVER experiments:

* A generic Trial Guidance Methodology is needed for analysing the need, and preparing, executing and reviewing an experiment \(i.e. Trial\).
* Only one Test-bed must be created and this must be used for each and every Trial.
* The Test-bed should be open source.
* The Test-bed should have a message-oriented architecture.
* The Test-bed should use well-defined, easily accessible, syntactically correct messages, and close to common standards.
* The Test-bed should be clearly defined and scoped, i.e. what it is, and what it is not.
* The Test-bed must be easily reproducible, and offer administrative as well as supporting tools and services.

![](/doc/img/test-bed-environment.jpg)_Figure Sum-2: Environment the Test-bed is used in_

The Test-bed will be used in the following environment:

* **Participants** are using the **Solutions** to solve a fictive crisis. Data-integration between these Solutions flows via the **Test-bed**.
* This fictive, virtual crisis exists in a virtual world created by a set of **Simulators** \(e.g. computer-based Simulators, or a fire brigade’s physical exercise terrain, or a combination of both\). Data-integration between the Simulators flows via the **Test-bed**.
* The **Trial Staff**, supported by the **Trial Guidance Methodology** and the **Training Module**, uses the Test-bed to:
  * Prepare the Trial - build the scenario and set-up and test all Solutions and Simulators required. 
  * Run the Trial - control how the virtual crisis scenario evolves, observe the Participants and gather data-logs from both the Solutions and the virtual crisis. 
  * Evaluate the Trial – gather and analyse all observations, recordings and data-logs, and base an evidence-based evaluation report on these.
* The Test-bed, Solutions and Simulators are available at the **Platform** \(i.e. one or more locations\), which provides rooms/areas for Participants to execute CM operations and rooms/areas for the Trial Staff. The Platform can be a simulation centre like available in The Hague, but can also be a live exercise terrain. 

![](/doc/img/test-bed-design.jpg)_Figure Sum-3: All components available within the Test-bed_

To support this use, the Test-bed must consist of the following components:

* The **Common Information Space \(CIS\)** is a central messaging bus with standardized CIS Adapters to connect Solutions to the Test-bed. 
* The **Common Simulation Space \(CSS\)** is a similar central messaging bus with standardized CSS Adapters to connect Simulators to the Test-bed. 
* The CIS and CSS are interlinked via one or more **Gateways** to feed Solutions with data from the simulated crisis meaning \(e.g. positions of virtual police cars driving around in the fictive region\) and to pass through changes inputted via one or more Solutions to the Simulators \(e.g. a command to block off an area\). A **Validation Service** can be added to safeguard messages are correctly filled and understandable by the counterpart.
* Both the CIS and the CSS are controlled via the **Test-bed Admin Tool**. This provides an interface for Trial Staff to control which Solutions and Simulators are to be started and which data is \(not\) exchanged.
* The **Trial Scenario Manager** and the **Time Service** components provide functionality and an interface for Trial Staff to create a high-over timeline of the Trial Scenario with Injects \(in the preparation-phase\), activate these Injects if needed \(in the execution-phase\) and control the fictive time clock \(in the execution-phase, meaning starting the Trial, pausing the fictive clock, fast-forwarding, jumping back in fictive time and stopping the Trial\).  
* The **Observer Support Tool \(OST\)** provides a module to prepare, make and gather observations. 
* The **After Action Review \(AAR\)** module gathers in execution-phase data-logs, Observations and \(screen-\) recordings, such that these can be reviewed.

For development and implementation purposes, the Test-bed should also come with:

* A **Message Injector** to input specific, single messages to test whether these messages are correctly received by another component.
* A **Play Service** to input several messages in chronological order.
* **Data Server\(s\)** to feed the Simulators and potentially also the Solutions with geo-specific information and map-layers. 
* A **Docker Environment** providing images \(i.e. installers\) of each component, such that the installation of \(a limited\) Test-bed can be done quickly and transparently.

The Test-bed will be delivered in 3 versions. Version 1 is intended for use in Trials 1 and 2, and consist of a limited number of components \(i.e. Scenario Manager and AAR not included and other components in first prototype quality\). Version 2 is to be used in Trials 3 and 4 and the Final Demo and comes with all components with a quality level surpassing that of a first prototype. It should contain data-sets and basic scenarios that can be used for effectively implementing and testing the Test-bed. The final version, Version 3, should have an even better quality based on experiences gathered from the use of the Test-bed in the executed Trials and is made available open-source on GitHub.

The development of the Test-bed is done within WP923. The test-bed and its development is:

* Linked to the evaluation of the Trial Guidance Methodology in WP922 
* Explained in the Training Module in T924.1
* Described in the Portfolio of Solutions, developed in WP93
* Used in the Trials of SP94
* Made available open-source to the support the sustainability of D+ results in WP954



