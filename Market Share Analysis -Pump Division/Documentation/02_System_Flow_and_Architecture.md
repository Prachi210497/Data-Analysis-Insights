# 02. System Flow and Architecture

## 1. Purpose of This Document

This document describes the **end-to-end system flow and technical architecture** of the Market Share Analysis solution. It explains how data moves from source systems to end-user dashboards and how different components interact to deliver secure, reliable insights.

---

## 2. High-Level Architecture Overview

The solution follows a **standard Business Intelligence architecture**, ensuring scalability, accuracy, and governance.

```
Source Systems
   ↓
Data Ingestion
(Power Query)
   ↓
Data Transformation & Validation
   ↓
Data Modeling Layer
(Relationships, Bridge Tables)
   ↓
Analytical Layer
(DAX Measures & KPIs)
   ↓
Visualization Layer
(Power BI Reports)
   ↓
Security Layer
(RLS)
   ↓
Power BI Service
(Workspace & Sharing)
   ↓
Business Users
```

---

## 3. System Flow Explanation

### Step 1: Data Sources

Multiple operational datasets are used as inputs:

* Order Booking (OB Data) - SAP/HANA
* Installed Base (IB Data) - Sharepoint 
* Service Person Mapping (Bridge Table)
* Calendar Table

These datasets originate from business operations and serve as the **single source of input** for the analytical solution.

---

### Step 2: Data Ingestion (Power Query)

* Data is imported into **Power BI Desktop**
* Power Query is used for:

  * Data type standardization
  * Column renaming
  * Error handling
  * Removal of duplicates and blanks

This step ensures that only **clean and validated data** moves forward.

---

### Step 3: Data Transformation & Validation

* Business rules are applied (e.g., pump status normalization)
* Invalid or inconsistent records are handled
* Date formats are standardized for time intelligence
* Logic is build in the columns to extract data from another table (Vlookup)

Validation checks are performed to ensure alignment with source data.

---

### Step 4: Data Modeling Layer

The cleaned datasets are structured into a **logical data model**:

* Fact tables: OB Data, IB Data
* Dimension tables: Customer, Calendar, Sales Person
* Bridge tables to manage **one-to-many relationships**
* Bridge tables to manage **many-to-many relationships** (Exceptional)

This layer ensures:

* Correct aggregation behavior
* Efficient filtering across tables
* Scalability for future enhancements

---

### Step 5: Analytical Layer (DAX)

* Business logic is implemented using **DAX measures**
* Measures handle:

  * Market share calculation
  * Cumulative potential value
  * Pump status classification
  * Context-aware filtering

The analytical layer separates **logic from visuals**, improving maintainability.

---

### Step 6: Visualization Layer

* Interactive dashboards are created using Power BI visuals
* Includes charts, tables, KPIs, and slicers
* Enables drill-down and cross-filtering

Design focuses on **clarity, usability, and decision-readiness**.

---

### Step 7: Security Layer (RLS)

* Row-Level Security is implemented using service-person mappings
* Users see only data relevant to their role or responsibility
* Security logic is tested for accuracy

This ensures **enterprise-grade data governance**.

---

### Step 8: Deployment & Access (Power BI Service)

* Reports are published to a Power BI Workspace
* User roles (Viewer / Contributor) are assigned
* Scheduled refresh and access control are managed centrally

---

## 4. Architecture Principles Followed

* Separation of data, logic, and presentation layers
* Reusability of measures and dimensions
* Performance-optimized modeling
* Security by design

---

## 5. Diagram Reference

Detailed diagrams are available in the `/Diagrams` folder:

* System Flow Diagram
* Data Model Diagram
* RLS Flow Diagram

---

## 6. Outcome

This architecture ensures a **robust, scalable, and secure BI solution** capable of supporting current business needs and future analytical expansion.


