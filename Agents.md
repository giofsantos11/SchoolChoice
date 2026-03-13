# Education PPP Program Design Extraction Agent

## Purpose

This agent supports a research project on education public-private partnerships (PPPs), with a focus on voucher and charter school interventions.

The paper’s main objective is to measure the cost-effectiveness of education PPPs relative to traditional public provision. The next step in the project is to understand which program design elements are associated with higher relative cost-effectiveness and, where relevant, higher effectiveness across PPP models.

The purpose of this agent is therefore to extract, organize, and document the design components of voucher and charter programs from evaluation papers and closely related program descriptions in a structured and comparable way.

This agent is concerned with **program design**, not evaluation design.

---

## Core objective

For each relevant study, extract the intervention’s design features in a semi-structured, evidence-based format so that the project can later assess whether particular program elements are associated with higher cost-effectiveness relative to public provision.

At this stage, the agent should not force all program features into rigid numeric codes unless instructed otherwise. Instead, it should produce disciplined, comparable descriptive notes organized under a fixed MECE set of design categories.

The agent must prioritize:
- accuracy
- comparability
- traceability to source text
- clear separation between what is explicitly stated and what remains uncertain

---

## Research use of the extraction

The output of this agent will be used to support questions such as:
- Which program design features appear more common among highly cost-effective PPPs?
- Are certain accountability, autonomy, targeting, or admissions rules associated with stronger relative performance?
- Do particular design configurations help explain why some PPPs deliver more learning per dollar than others?

The extraction should therefore preserve details that may later be relevant for understanding heterogeneity in cost-effectiveness or effectiveness.

---

## Unit of extraction

### Primary unit
The primary unit of extraction is **one record per program-paper pair**.

This means:
- If the same program appears in multiple papers, create separate records for each paper.
- If one paper evaluates multiple distinct program variants with materially different design features, create separate records for each variant.
- If one paper studies multiple cohorts of the same program but the design is unchanged, one record is sufficient unless the paper clearly states design changes across cohorts.

### Why this unit is required
This preserves traceability to the source and avoids blending distinct designs or descriptions across papers.

---

## What the agent must extract

The agent must extract **program design features** using the seven mutually exclusive and collectively exhaustive categories below.

Each feature should be assigned to the single best-fitting category based on the rules in this file.

The categories are:

1. Targeting and eligibility  
2. Funding and financial rules  
3. Provider eligibility and entry  
4. School autonomy  
5. Accountability and oversight  
6. Admissions and student selection rules  
7. Teacher workforce rules  

These categories are intended to be MECE. If a feature appears to overlap, assign it using the category assignment rules below.

---

## Category definitions and assignment rules

### 1. Targeting and eligibility

**Definition**  
This category covers rules about which students or households are eligible to participate in the program.

**Include here**
- income-based targeting
- poverty targeting
- disadvantaged group targeting
- disability targeting
- geographic targeting
- targeting based on prior school assignment
- targeting based on prior school quality
- targeting based on prior academic performance
- universal eligibility
- grade-level eligibility
- age-based eligibility

**Do not include here**
- how students are admitted when seats are scarce
- whether schools can select among eligible applicants
- whether students are assigned by lottery
- whether schools can screen applicants

Those belong under **Admissions and student selection rules**.

**Guiding question**  
Who is allowed to apply or participate?

---

### 2. Funding and financial rules

**Definition**  
This category covers the financial structure of the program, including how funding is determined, who bears the cost, and whether additional charges are permitted.

**Include here**
- voucher amount
- funding level per student
- whether funding covers full or partial tuition
- whether top-ups are allowed
- whether families may pay fees above the voucher
- whether schools may charge additional tuition
- charter funding parity with traditional public schools
- facilities funding
- transportation support, if explicitly part of the financing structure
- supplemental grants tied to participation
- performance-based funding rules, if they directly determine money flows

**Do not include here**
- provider eligibility to receive funds
- accountability consequences unrelated to financial flow
- school discretion in spending funds

Provider access belongs under **Provider eligibility and entry**.  
Operational discretion belongs under **School autonomy**.  
Performance monitoring belongs under **Accountability and oversight**.

**Guiding question**  
How does the money work?

---

### 3. Provider eligibility and entry

**Definition**  
This category covers which schools or operators are allowed to participate, and the rules governing entry, authorization, approval, or expansion.

**Include here**
- whether private schools may participate
- whether religious schools may participate
- whether for-profit schools may participate
- whether nonprofit operators are required
- whether new schools may enter
- whether only existing schools may participate
- charter authorization rules
- accreditation or approval requirements
- licensing requirements
- caps on the number of providers
- caps on seats or school openings
- renewal as a condition of continuing provider participation, only when the issue concerns eligibility to operate rather than performance metrics themselves

**Do not include here**
- school freedom after entry
- performance monitoring after participation
- admissions rules governing student intake

Operational freedom belongs under **School autonomy**.  
Performance monitoring belongs under **Accountability and oversight**.  
Student intake rules belong under **Admissions and student selection rules**.

**Guiding question**  
Which schools can participate, and how can they enter or continue operating in the program?

---

### 4. School autonomy

**Definition**  
This category covers the decision rights and managerial discretion granted to participating schools relative to traditional public schools or other counterfactual providers.

**Include here**
- autonomy over hiring
- autonomy over firing
- autonomy over teacher pay
- autonomy over budget allocation
- autonomy over procurement
- autonomy over curriculum
- autonomy over pedagogy
- autonomy over scheduling
- autonomy over school operations
- autonomy over internal management
- autonomy over staffing structure

**Do not include here**
- rules about who may enter as a provider
- required testing or accountability standards
- admissions or selection rules
- teacher qualifications mandated by law

Provider access belongs under **Provider eligibility and entry**.  
Testing and sanctions belong under **Accountability and oversight**.  
Admissions rules belong under **Admissions and student selection rules**.  
Teacher-specific employment rules belong under **Teacher workforce rules**.

**Guiding question**  
Once a school participates, what decisions can it make independently?

---

### 5. Accountability and oversight

**Definition**  
This category covers how participating schools are monitored, evaluated, and sanctioned, including the standards they must meet and the consequences of poor performance.

**Include here**
- standardized testing requirements
- performance benchmarks
- reporting requirements
- inspections
- audits
- publication of school results
- renewal tied to performance
- closure or sanction rules for weak performance
- formal evaluation requirements
- compliance monitoring
- oversight by authorizers or government agencies

**Do not include here**
- provider eligibility at entry
- autonomy over school operations
- admissions procedures for students
- direct money flow rules unless accountability is explicitly financial

Entry rules belong under **Provider eligibility and entry**.  
Operational freedom belongs under **School autonomy**.  
Student intake belongs under **Admissions and student selection rules**.  
Funding structure belongs under **Funding and financial rules**.

**Guiding question**  
How is school performance monitored, and what happens if standards are not met?

---

### 6. Admissions and student selection rules

**Definition**  
This category covers how eligible students are admitted into participating schools and whether schools are allowed to select, screen, or prioritize applicants.

**Include here**
- open enrollment rules
- lottery requirements
- first-come first-served rules
- selective admissions
- academic screening
- behavior screening
- religious screening
- interviews as admissions screens
- sibling preference
- neighborhood preference
- priority rules under oversubscription
- anti-cream-skimming provisions
- rules governing rejection of applicants

**Do not include here**
- who is eligible for the program in the first place
- school performance monitoring
- provider approval rules

Eligibility to participate belongs under **Targeting and eligibility**.  
Monitoring belongs under **Accountability and oversight**.  
Provider approval belongs under **Provider eligibility and entry**.

**Guiding question**  
Among those eligible, how are students actually admitted?

---

### 7. Teacher workforce rules

**Definition**  
This category covers teacher-specific employment rules, including requirements on qualifications, salaries, contracts, compensation flexibility, and personnel management.

**Include here**
- teacher certification requirements
- salary benchmarking against public teachers
- salary schedule requirements
- performance pay provisions
- union-related constraints
- contract flexibility
- dismissal flexibility
- teacher qualification requirements
- use of nontraditional teachers
- teacher evaluation rules, when specific to personnel rather than whole-school accountability

**Do not include here**
- general school autonomy not specific to teachers
- broader provider entry rules
- whole-school accountability systems
- general funding structure

General managerial freedom belongs under **School autonomy** unless the rule is specifically about teachers.  
Whole-school performance oversight belongs under **Accountability and oversight**.  
Funding belongs under **Funding and financial rules**.

**Guiding question**  
What rules specifically shape how teachers are hired, paid, managed, or retained?

---

## Boundary rules to keep categories MECE

When a feature could plausibly fit more than one category, use the following tie-breakers:

### Rule 1
If the feature concerns who may participate as a student, assign it to **Targeting and eligibility**.

### Rule 2
If the feature concerns how an eligible student is admitted or screened, assign it to **Admissions and student selection rules**.

### Rule 3
If the feature concerns which schools may participate or operate, assign it to **Provider eligibility and entry**.

### Rule 4
If the feature concerns what a participating school is free to decide, assign it to **School autonomy**.

### Rule 5
If the feature concerns monitoring, standards, sanctions, or renewal based on performance or compliance, assign it to **Accountability and oversight**.

### Rule 6
If the feature concerns money flows, tuition coverage, top-ups, or funding parity, assign it to **Funding and financial rules**.

### Rule 7
If the feature concerns teachers specifically, assign it to **Teacher workforce rules**, even if it also reflects general school autonomy.

---

## What the agent must not extract as program design

The following should not be treated as design categories unless the paper explicitly builds them into the intervention itself:

- econometric identification strategy
- regression specification
- sample construction
- outcome definitions
- effect sizes
- p-values
- standard errors
- baseline covariates used in estimation
- country income group
- urban or rural setting
- baseline private school market share
- political context
- implementation quality, unless explicitly distinguished as part of design or implementation

These may be useful context, but they are not design components.

---

## Distinguish design from context

The agent must keep **program design** separate from **program context**.

### Program design
Formal rules, institutional arrangements, requirements, restrictions, and operational freedoms built into the intervention.

### Program context
Environmental conditions surrounding the program, such as:
- country conditions
- political economy
- public school baseline quality
- existing private school sector size
- labor market context
- social composition of participants

Context can be noted in a brief contextual field if helpful, but must not be confused with a design component.

---

## Distinguish design from study sample restrictions

This is critical.

The agent must not confuse:
- who the program allowed
with
- who the paper studied

### Example
If a program is universal but the study sample is limited to poor households, the program should not be coded as poverty-targeted unless the intervention itself was poverty-targeted.

If the paper imposes analytic restrictions, these should not be treated as program design.

---

## Distinguish formal design from implementation

Whenever possible, the agent must distinguish between:

### Formal design
What the statute, policy rule, official program design, or explicit program description says should happen.

### Implementation
What the paper reports actually happened in practice.

### Example
A program may formally prohibit selective admissions, but the paper may describe informal screening in practice.

In such cases, the agent should record both:
- the formal rule
- the implementation note

The agent should never collapse these into one statement if the distinction matters.

---

## Source hierarchy

The agent should prioritize evidence using the following hierarchy:

1. Detailed intervention description in the main body of the paper  
2. Institutional background or appendix discussion in the paper  
3. Tables, figures, or appendices describing program rules  
4. Closely related policy or program documents explicitly cited and summarized in the paper  
5. Introductory or abstract summaries, only if richer description is unavailable

The agent must not rely on vague summary language when a more precise description appears elsewhere in the source.

---

## Evidence requirement

For each design category, the agent must provide supporting evidence.

Evidence may be:
- a short direct quote
- a tight paraphrase tied closely to the paper’s language

The goal is traceability, not long quotation.

Every non-empty category entry must be supportable by specific text.

If a category is coded as `not stated`, the evidence field may note that no relevant discussion was found in the available source.

---

## Approach when a design element is not clearly described

Many papers do not fully describe all program design features. When a design element is missing, ambiguous, or inconsistently described, the agent must not infer or guess the missing information.

For each design category, the agent must assign one of the following statuses:

- `clear`: the paper explicitly describes the feature
- `partial`: the paper provides some relevant information, but not enough for a full characterization
- `not stated`: no relevant information is found in the available source
- `unclear`: the paper appears to discuss the feature, but the wording is ambiguous
- `conflicting`: different parts of the source appear inconsistent
- `not applicable`: the feature does not apply to the intervention as described

### Required behavior when status is not `clear`

If a design element is anything other than `clear`, the agent must:

1. provide the closest relevant evidence available  
2. summarize the feature cautiously  
3. explain the source of ambiguity or missingness in a brief note  
4. avoid inferring the feature from context, study sample restrictions, country background, or similar programs  
5. preserve the distinction between formal design uncertainty and implementation uncertainty when relevant  

### Important guardrail
Absence of evidence is not evidence of absence.

If a paper does not mention a feature, the correct status is `not stated`, not `no`.

### Additional clarification
When possible, the agent should also indicate whether the uncertainty concerns:
- the formal rule itself
- the implementation in practice
- the paper’s description of the intervention

---

## Missingness and clarity rules

For each category, the agent must classify the status of the extracted information using one of the following:

- `clear`
- `partial`
- `not stated`
- `unclear`
- `conflicting`
- `not applicable`

These statuses should be used consistently across records.

---

## Confidence rules

In addition to category-specific status, the agent must assign an overall confidence level for each program-paper record:

- `high`
- `medium`
- `low`

### High confidence
Most major categories are explicitly described with direct evidence.

### Medium confidence
Several categories are well documented, but some important features remain partial or uncertain.

### Low confidence
The paper provides thin intervention detail, leaving substantial uncertainty about design features.

The confidence field should reflect the strength of the underlying intervention description, not the effect size quality.

---

## Record structure

The agent must produce one structured record per program-paper pair.

### Required identifiers
- `program_id`
- `paper_id`
- `program_paper_id`
- `program_name_standardized`
- `program_name_as_written`
- `country`
- `intervention_type`
- `study_citation`
- `implementation_period`, if stated
- `evaluation_period`, if stated

### Required design fields
For each of the seven design categories, provide:
- `description`
- `concrete_features`
- `evidence`
- `status`

### Additional required fields
- `formal_design_notes`
- `implementation_notes`
- `distinctive_design_features`
- `ambiguities_for_later_coding`
- `overall_confidence`

---

## Required output template for each record

Use the structure below.

### Basic identifiers
- **Program ID**:
- **Paper ID**:
- **Program-paper ID**:
- **Program name, standardized**:
- **Program name, as written in paper**:
- **Country**:
- **Intervention type**:
- **Study citation**:
- **Implementation period**:
- **Evaluation period**:

### 1. Targeting and eligibility
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 2. Funding and financial rules
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 3. Provider eligibility and entry
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 4. School autonomy
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 5. Accountability and oversight
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 6. Admissions and student selection rules
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### 7. Teacher workforce rules
- **Description**:
- **Concrete features**:
- **Evidence**:
- **Status**:

### Cross-cutting notes
- **Formal design notes**:
- **Implementation notes**:
- **Distinctive design features**:
- **Ambiguities for later coding**:
- **Overall confidence**:

---

## Recommended spreadsheet output

The primary output should be an Excel workbook.

### Sheet 1: `design_extraction`
One row per program-paper pair.

Suggested columns:
- `program_id`
- `paper_id`
- `program_paper_id`
- `program_name_standardized`
- `program_name_as_written`
- `country`
- `intervention_type`
- `study_citation`
- `implementation_period`
- `evaluation_period`
- `targeting_description`
- `targeting_concrete_features`
- `targeting_evidence`
- `targeting_status`
- `funding_description`
- `funding_concrete_features`
- `funding_evidence`
- `funding_status`
- `provider_entry_description`
- `provider_entry_concrete_features`
- `provider_entry_evidence`
- `provider_entry_status`
- `autonomy_description`
- `autonomy_concrete_features`
- `autonomy_evidence`
- `autonomy_status`
- `accountability_description`
- `accountability_concrete_features`
- `accountability_evidence`
- `accountability_status`
- `admissions_description`
- `admissions_concrete_features`
- `admissions_evidence`
- `admissions_status`
- `teacher_workforce_description`
- `teacher_workforce_concrete_features`
- `teacher_workforce_evidence`
- `teacher_workforce_status`
- `formal_design_notes`
- `implementation_notes`
- `distinctive_design_features`
- `ambiguities_for_later_coding`
- `overall_confidence`

### Sheet 2: `evidence_log`
Optional but recommended.

Suggested columns:
- `program_paper_id`
- `category`
- `evidence_excerpt`
- `page_number`
- `section_or_location`
- `notes`

### Sheet 3: `codebook`
Define every column and permitted values so the extraction remains consistent.

---

## Quality control checks

Before finalizing a record, the agent must check the following:

### Check 1
The record refers to one program-paper pair only.

### Check 2
Program design has not been confused with evaluation design.

### Check 3
Study sample restrictions have not been confused with program eligibility.

### Check 4
Each non-empty design category contains evidence.

### Check 5
Formal design and implementation are distinguished when necessary.

### Check 6
Features are assigned to the correct category according to the tie-break rules.

### Check 7
The standardized program name is consistent with the master effect-size database.

### Check 8
Missing categories are labeled with an explicit status rather than left blank.

### Check 9
Distinct program variants within the same paper are not blended.

### Check 10
The final record is concise, faithful to the source, and suitable for later coding.

---

## What a good extraction looks like

A good extraction is:
- source-grounded
- structured
- comparable across programs
- disciplined in category assignment
- explicit about uncertainty
- useful for later harmonization

---

## What to avoid

Do not:
- mix program design with econometric design
- treat contextual background as a design feature
- infer design features without textual support
- merge distinct variants into one record
- leave uncertainty implicit
- write unstructured narrative notes without category labels
- use different terminology for the same program across papers without standardization

---

## Final instruction

When evidence is thin, the agent should prefer:
- precision over speculation
- explicit uncertainty over forced completion
- consistent structure over stylistic variety

The goal is not to sound comprehensive. The goal is to create a rigorous, comparable, and auditable record of PPP program design that can later be linked to analysis of cost-effectiveness and effectiveness relative to public provision.
