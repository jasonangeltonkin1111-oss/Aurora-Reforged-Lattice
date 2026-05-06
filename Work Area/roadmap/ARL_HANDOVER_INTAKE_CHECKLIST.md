# ARL Handover Intake Checklist

Run: ARL-RUN009G  
Status: Mandatory for handovers, pasted reports, compile logs, zip reviews, and prompt-building

---

## Intake Questions

Before acting on a handover, answer:

```text
What run is this?
What is the latest Git commit/run?
What source package is active?
Is the zip a current Work Area tree or old run-pack bundle?
What did the user ask for?
Is this audit, prompt build, patch, debug, research, roadmap, or explanation?
What evidence is available?
What evidence is missing?
Does the task require Git check?
Does the task require Archive inspection?
Does the task require external research?
Does compile proof exist?
Does runtime proof exist?
Does live proof exist?
What files must be read?
What files are forbidden?
What is the report path?
What is the package name?
What version impact is expected?
```

---

## Evidence Sorting

Classify handover evidence:

```text
User statement
Screenshot
Pasted compile output
Uploaded zip
Git commit
Direct source inspection
Static validation
Compile output
Runtime output
Live evidence
```

Do not let lower evidence pretend to be higher evidence.

---

## Zip Classification

Determine whether the uploaded file is:

```text
current full Work Area
changed-files-only package
old run-pack bundle
Archive bundle
unknown/mixed
```

If it is a bundle of old packs, do not treat it as current source.

---

## Compile Claim Check

If the user says “compiles now,” ask or inspect:

```text
Is compile output pasted?
Which file compiled?
Which build?
Any warnings?
Any errors?
Was it after latest changes?
```

If compile output is absent, say compile is user-reported, not independently proven.

---

## Prompt Build Checklist

Before writing a prompt, ensure it includes:

```text
run ID
mode
source package
current Git state
archive findings
mandatory reads
research requirement
patch scope
forbidden scope
version decision
acceptance tests
falsifiers
report location
output package
Git Summary
Git Description
```
