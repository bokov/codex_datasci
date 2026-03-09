# Project Charter

## Vision
Create a configurable simulation engine that generates realistic, interconnected, messy datasets for data science training.

## Problem statement
Existing educational datasets frequently omit real-world friction (schema drift, delayed arrival, inconsistent IDs, changing definitions, missing data, noisy labels, many-to-many relationships, and temporal ambiguity).

## Target users
- Self-learners in data science/statistics.
- Instructors building applied exercises.
- Teams practicing analytics engineering and ML pipeline robustness.

## Goals
1. Simulate multiple interacting data-generating processes (DGPs).
2. Produce both event-level and derived tabular data with realistic imperfections.
3. Support configurable observation points (partial observability, different system boundaries).
4. Enable repeatable scenarios with seed control and scenario configs.
5. Provide curated exercises that emphasize data wrangling and inference under uncertainty.

## Non-goals (initially)
- Photorealistic domain simulation.
- Full enterprise-scale distributed systems.
- Perfectly faithful reproduction of any one real-world domain.
- Building a full teaching LMS.

## Success criteria
- Users can generate at least 3 distinct training scenarios from config files.
- At least 10 realistic failure/friction modes are supported.
- Scenarios are reproducible from seed + config.
- Exercises can be solved end-to-end with documented expected learning outcomes.

## Risks
- Overengineering before first runnable MVP.
- Excess complexity reducing pedagogical clarity.
- Simulation realism outrunning validation discipline.

## Mitigations
- MVP-first roadmap with explicit scope caps.
- ADR process for major design choices.
- Scenario validation checklist and regression tests.
