# The DRIVER+ project

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

In order to achieve these objectives, five sub-projects \(SPs\) have been established. **SP91 Project Management** is devoted to consortium level project management, and it is also in charge of the alignment of DRIVER+ with external initiatives on crisis management for the benefit of DRIVER+ and its stakeholders. In DRIVER+, all activities related to SIA \(from the former SP8 and SP9\) are part of SP91 as well. **SP92 Testbed** will deliver a Guidance methodology and guidance tool supporting the design, conduct and analysis of trials and will develop a reference implementation of the test-bed. It will also create the scenario simulation capability to support execution of the Trials. **SP93 Solutions** will deliver the Portfolio of Solutions \(PoS\) which is a database driven web site that documents all the available DRIVER+ solutions, as well as solutions from external organisations. Adapting solutions to fit the needs addressed in trials, will be done in SP93. **SP94 Trials** will organize four series of trials as well as the final demo. **SP95 Impact, Engagement and Sustainability**, is in charge of communication and dissemination, and also addresses issues related to improving sustainability, market aspects of solutions, and standardization.

The DRIVER+ trials and the Final Demonstration will benefit from the DRIVER+ Test-bed, providing the technological infrastructure, the necessary supporting methodology and adequate support tools to prepare, conduct and evaluate the trials. All results from the trails will be stored and made available in the Portfolio of Solutions, being a central platform to present innovative solutions from consortium partners and third parties and to share experiences and best practices with respect to their application. In order to enhance the current European cooperation framework within the Crisis Management domain and to facilitate a shared understanding of Crisis Management across Europe, DRIVER+ will carry out a wide range of activities, whose most important will be to build and structure a dedicated Community of Practice in Crisis Management \(CoPCM\), thereby connecting and fostering the exchange on lessons learnt and best practices between Crisis Management practitioners as well as technological solution providers.

# 1.   Introduction

This document is intended to serve as functional requirements specifications for the Driver+ Test-Bed. This Test-Bed is intended to provide software components that support organisations in running and evaluating a Trial, in which one or more solutions \(e.g. software tools\) are tested about their benefits \(or negative influence\) w.r.t. crisis management. The Test-Bed components are designed and developed within Work-Package 923 and linked Work-Packages for specific components \(ADD WP numbers\).   

This document is linked to D923.21 that describes a reference implementation of the Test-Bed’s components, including design and development choices taken per component. This document only states the functional requirements to these components and not how exactly these are fulfilled. 

In several chapters, this document provides:

* The high-over use-cases of the entire DRIVER+ Test-bed in the environment it is used in, in the different phases of use and the different user-types \(ADD CHAPTER HYPERLINK\),
* The functional specifications of this Test-bed and the components it therefore exists of \(ADD CHAPTER HYPERLINK for high-over use-cases and ADD CHAPTER HYPERLINK for functional specifications per component\), The latter chapter also provides links for each component to separate, more detailed specification documents of each component,
* The process how these specifications were drafted \(ADD CHAPTER HYPERLINK\)[ADDITION BY HECTOR],
* The lessons learned from the Test-bed[ADDITION BY HECTOR] as developed and used in experiments in the former [ADDITION BY HECTOR]DRIVER project \(ADD CHAPTER HYPERLINK\)[ADDITION BY HECTOR],
* What can be concluded from the functional specifications of the DRIVER+ Test-bed, the high-over development cycle and the development dependencies of these Test-bed components with regards to other WPs and SPs.

## 1.1   Targeted reading audience

This document is targeted at readers who know the DRIVER+ aims and project-contents at least at a high-over level. They should also have a minimal level of understanding of functional design and software development.

Primary target audiences of this document are:

* Software designers, developers and testers from within the DRIVER+ consortium and from external Solution and Simulator providers[ADDITION BY HECTOR],
* Trial Committee members[ADDITION BY HECTOR],
* DRIVER+ Guidance Methodology developers[ADDITION BY HECTOR],
* Reviewers of this document as deliverable D923.11[ADDITION BY HECTOR],
* DRIVER+ externals, who are interested in what the Test-Bed can bring them[ADDITION BY HECTOR].

Readers interested in how a specific component functions, the design and development choices made during its development and the way to implement these components, are referred to D923.21 Reference Implementation. 

For reading this document, one must have an internet connection capable of reaching the GitBook website. For editing and reviewing this document, a personal GitHub-account is required with which one can request and be given access to the DRIVER+ GitHub group.

## 1.2   Online living document on GitBook

The documentation of the Test-Bed’s functional specifications is completely done in the online developer tool GitBook, a website linked to the popular developer community GitHub in which software code can be created, shared and adjusted. GitBook is a website on which documents can be placed, read and adjusted. The decision to use GitBook instead of documenting all functional specifications in MS Word on the DRIVER+ COW, is based on the considerations that:

**GitHub and its affiliative GitBook is targeted specifically for software development**  
The overall majority of man-months spend on the Test-bed’s development is in fact software development,

**Specifications are living documents**  
All the Test-bed’s specification documents are foreseen to be living documents to include progressing knowledge on the Test-bed and practical considerations and decisions made during the development and use of the Test-bed, like common in any software development project. This requires a documentation process and tooling that can deal with these ongoing updates/changes to the specifications.

**Parallel, agile development**  
GitHub and GitBook are developed specifically for parallel \(agile\) software development and for easy sharing of documents and their updates amongst developers. In the agile software development method, multiple developers work in parallel on the same/linked software components and the component’s specifications are updated as development progresses immediately taking experiences gained in account. This principle of the ability to update as work progresses is the reason to use a living document structure. GitBook is a well proven documentation tool to create, share and update living documents.

**Versioning and tracking**  
GitHub and GitBook contain an elaborate versioning and tracking system known by the overall majority of European software developers, where the Track-changes and multiple simultaneous document update functions as available in MS Word are less known to them.

**Share open-source code on GitHub**  
GitHub is a platform to share software code and work on this code by multiple developers at different locations. This sharing of code is required because:

* Different D+ partners from around Europe work on the Test-bed’s development,
* And all software created specifically for the Test-bed should be open source and thus sharable on a platform like GitHub.

**Documentation and code together**  
Having the code and the specifications documents together on one online repository, makes development work and sharing of this work much easier, findable and understandable for all involved and for external parties. GitBook and GitHub originate from the same platform and are already linked to each other. Using GitBook next to GitHub is thus the most logical choice.

