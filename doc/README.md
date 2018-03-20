# 1.   Introduction

This document is intended to serve as functional requirements specifications for the DRIVER+ Test-bed. This Test-bed is intended to provide software components that support organisations in running and evaluating a Trial, in which one or more solutions \(e.g. software tools\) are tested about their benefits \(or negative influence\) w.r.t. crisis management. The Test-bed components are designed and developed within Work-Package 923 and linked Work-Packages for specific components \(ADD WP numbers\).

This document is linked to D923.21, D923.22 and D923.23 that describe a reference implementation of the released version of the Test-bed’s components, including design and development choices taken per component. This document merely states the functional requirements for these components \(i.e. what these components must/should do and why this is needed\). How these requirements are fulfilled and design/development choices made during the component's development is documented in the Reference Implementation documentation. Note that 3 versions of the Test-bed are foreseen, each encompanied with its own Reference Implementation deliverable.

In several chapters, this document provides:

* The high-over use-cases of the entire DRIVER+ Test-bed in the environment it is used in, in the different phases of use and the different user-types \(ADD CHAPTER HYPERLINK\). 
* The functional specifications of this Test-bed and the components it therefore exists of \(ADD CHAPTER HYPERLINK for high-over use-cases and ADD CHAPTER HYPERLINK for functional specifications per component\). The latter chapter also provides links for each component to separate, more detailed specification documents of each component. 
* The process how these specifications were drafted \(ADD CHAPTER HYPERLINK\). 
* The lessons learned from the Test-bed as developed and used in experiments in the old DRIVER-project \(ADD CHAPTER HYPERLINK\). 
* What can be concluded from the functional specifications of the DRIVER+ Test-bed, the high-over development cycle and the development dependencies of these Test-bed components with regards to other WPs and SPs.

## 1.1   Targeted reading audience

This document is targeted at readers who know the DRIVER+ aims and project-contents at least at a high-over level. They should also have a minimal level of understanding of software functional design.

Primary target audiences of this document are:

* Software designers, developers and testers creating a part of the Test-bed and/or wanting to use the Test-bed,
* Trial Committee members \(i.e. people involved in the organization of Trials within DRIVER+\),
* DRIVER+ Trial Guidance Methodology \(TGM\) developers and those supporting the implementation of this TGM,
* DRIVER+ externals, who are interested in what the Test-Bed can bring them.

Readers interested in how a specific component functions, the design and development choices made during its development and the way to implement these components, are referred to the Reference Implementation documentation per version of the Test-bed \(i.e. D923.21, D923.22 and D923.23\).

The core of this deliverable is an online version of it, published on GitBook.com. For official delivery of D923.11 in M47 \(March 2018\), this online version will be copied into a single-moment-in-time MS Word and PDF document. These .doc and .pdf-files can be accessed on the DRIVER+ Common Online Workspace for those with a DRIVER+-account.   
The online document on GitBook.com will be a living document, which is updated throughout the development of the Test-bed. For reading the online, most recent version of this document, one must have an internet connection capable of reaching the GitBook website. For editing and reviewing this document, a personal GitHub-account is required with which one can request and be given access to the DRIVER+ GitHub group.

## 1.2   Online living document on GitBook

The documentation of the Test-bed’s functional specifications is completely done in the online developer tool GitBook, a website linked to the popular developer community GitHub in which software code can be created, shared and adjusted. GitBook is a website on which documents can be placed, read and adjusted. As stated, for official delivery an ofline copy will be made once in March 2018, and delivered as both an MS Word and PDF-file. 

The decision to use GitBook for creating these functional specifications \(i.e. instead of using MS Word for all documentation for D923.11\) is based on the considerations that:

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

