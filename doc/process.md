# 2. Work-process used to come up with the Test-bed specifications

This chapter explains how we came up with the specifications as stated in this document:

* Analysis of lessons learned from the old DRIVER
* Detailing based on the high-over design as stated in the Description Of Work \(DOW\)
* Use-case analysis and cutting up the envisioned design in sub-functions
* Discuss practical \(im\)possibilities with the trial-owners and other end-users
* Consultation with solutions coordinators and development partners
* Market research of technologies already out there
* Experience from custom-made and off-the-shelf developments and implementation projects conducted by the Test-bed’s development partners

To be continued.This chapter explains the process used to draft the functional requirement specifications, which are documented in this deliverable. This iterative requirements design-process was used by the Test-Bed’s core-development organisations \(FRQ, TNO and XVR\) and by the other development and review partners \(AIT, ITTI and THS and AIT; GMV, JRC and WWU\).

The process followed is not an exact copy of a single, specific design or software-development method, but is based on the generic agile software development method, currently used by the majority of software-developers worldwide. This agile process encompasses multiple parallel design and development efforts going on at the same time. Experts of different domains \(e.g. functional designer vs. software developers, or organisation creating component A vs. organisation developing component B\), work on their own component and meet regularly to discuss the overall architecture and links between these components. The WP-leader \(i.e. TNO\) maintains an overview over all components and the high-over architecture of the entire Test-bed and thereby actively steers the requirements design process.

![D+ Process](img/process.png)

_Figure 2.1: Iterative process used for setting the Test-Bed's specifications_

The iterative requirements design process followed is visualized in figure 2.1. The following 9 steps can be distinguished in this process, but note that the order of these steps stated here differs in each round the iterative process is followed:

**I.    **The design process is started by gathering lessons learned from the old DRIVER. The outcomes are documented in the [next chapter](lessons-learned.md#Lessons-learned). Every time a development partner, Trial–owner or Solution-owner is included/consulted who has participated in old DRIVER experiments, their experiences in these are taken in account.

**II.    **The high-level use-cases of the entire Test-Bed are considered. This quickly led to the fact that the Test-Bed is split up in multiple components, due to the different functionalities of these components and to be able to divide the work amongst multiple development partners.

**III.    **For each component \(and functional/technical sub-component\) a market research is done about what is already available off-the-shelve, to prevent development efforts are wasted on designing and making everything from scratch while a sufficiently functioning component is already available. Sometimes these components can be directly included in the D+ Test-bed \(e.g. open source Kafka technology\), sometimes parts are re-used from the old DRIVER \(e.g. partly the CIS architecture and base technologies\) and sometimes only the functional design is reviewed and partly copied \(e.g. the NATO exercise management tool JEMM\). To prevent IP infringements n the latter case, references are made to products/technologies the component is based on.

**IV.    **Next to off-the-shelve components and technologies, also the experiences of development partners in similar projects are used to draft the Test-Bed’s specifications. For instance the Observer Module, as made by Middlesex University, Netherlands Aerospace Laboratory and XVR in the FP7-project CRISIS, served as a source of design input for the Test-bed’s Observer Support Tool \(ADD 5.X PARAGRAPH HYPERLINK\).

**V.    **Other Solution owners within the D+ consortium are consulted regarding technical link-abilities, as one of the primary functions of the Test-Bed is to let Solutions \(i.e. software tools\) digitally link up with the Test-Bed to exchange information in between these Solutions and with other components. Next to Solution-owners included in the D+ consortium, also potential external Solution providers are considered, both because each Trial’s call for solutions is open to externals and because of the required sustainability of the D+ Test-Bed.

**VI.    **Similarly like consulting Solution-owners, the possibilities and impossibilities at Trial-owners are also reviewed. The Test-Bed must be able to function at all Trial-owners included in the D+ consortium and for the Test-bed’s sustainability outside the D+ project it must also be relatively easy to be implemented at other locations.

**VII.    **Steps IV, V and VI together define the context in which the Test-Bed must be able to function. Next to from the characteristics of the environment the Test-Bed is to be implemented in \(e.g. computer hardware can be located indoors and does not have to be packed weather-proof\), this contextual description also provides a set of constraints on the Test-Bed \(e.g. Test-bed’s core must be able to function without a high-end full-time available internet connection, as some Trial-owners cannot guarantee this availability 24/7 at their site\).

**VIII.    **All these requirements \(i.e. in detail a set of functional and technical requirements and wishes\) are documented. This documentation forms this deliverable D923.11. As know-how about the Test-Beds components and their functioning grows during development of these components and the use of them during Trials, D923.11 is a living document which is updated whenever specifications are changed or elaborated.

**IX.    **The drafting of these requirement specifications is done in parallel with the functional and technical design. This design and the specification efforts highly influence each other. So although design decisions are documented in D923.21 Reference Implementation \(ADD DOCUMENT HYPERLINK\), this steps forms an integral part of the requirements specification process.

This requirements specification process circle is followed many times. When viewed from a distance, four main phases can be distinguished:

1. This process was followed already by the core development partners when the description and main ideas behind WP923 were agreed upon and documented in the DOW. This resulted in the main ideas behind WP923 and the description of this work-package in the DOW.
2. At start of WP923, the core development partners TNO, XVR and FRQ had face-to-face and remote specification and design meetings, going through all of the Test-Bed’s components, what they are intended for, how they are linked and the high-over functional and technical design of them. The outcomes were documented in the meetings’ minutes.
3. Following these high-level specification and design meetings, both internal meetings and face-to-face and remote meetings with other component developers were organised. The high-level specifications and designs were shared and these were then further detailed and documented in component specific documentation \(see also ADD CHAPTER 5 HYPERLINK\).
4. During the development of each component, the specifications and designs are further detailed and updated. This phase will continue when the Test-Bed is used in Trials. The outcome of this phase are the components and updates on the living documents.



