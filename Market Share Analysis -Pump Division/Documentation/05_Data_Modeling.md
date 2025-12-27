## 1. Objective

The objective of data modeling was to **design a structured, scalable, and performance-optimized data model** that supports accurate market share calculations, trend analysis, and executive reporting.

A **star schema approach** was adopted to ensure clarity, flexibility, and ease of maintenance.

---

## 2. Data Modeling Approach

A **star schema** was implemented, consisting of:

* One central **fact table** capturing measurable business metrics
* Multiple **dimension tables** providing descriptive business context

This approach supports efficient DAX calculations and improves report performance in Power BI.

Below is a **clean, relationship table**
## Relationships Overview

The following table summarizes the relationships implemented in the Power BI data model. These relationships enable accurate filtering, role-based access, and time-based analysis across Installed Base (IB) and Order Booking (OB) data.

| From Table | From Column    | To Table       | To Column      | Cardinality | Filter Direction | Status   | Purpose                                                |
| ---------- | -------------- | -------------- | -------------- | ----------- | ---------------- | -------- | ------------------------------------------------------ |
| IB_Data    | Concatenate    | Pump_MALP_List | Concatenate    | Many → One  | Single           | Active   | Product mapping between Installed Base and Pump master |
| IB_Data    | Customer Name  | OB_Data        | Customer Name  | Many ↔ Many | Both             | Active   | Customer-level linkage across IB and OB datasets       |
| IB_Data    | Invoice Date   | Calendar       | Date           | Many → One  | Single           | Active   | Time-based analysis for Installed Base data            |
| IB_Data    | Service Person | SAM_Bridge     | Service Person | Many → One  | Single           | Active   | Mapping service personnel to sales hierarchy           |
| IB_Data    | Service Person | RLS            | Service Person | Many → One  | Single           | Inactive | Reserved for role-level security control               |
| OB_Data    | Service Person | SAM_Bridge     | Service Person | Many → One  | Single           | Active   | Aligning Order Booking data with service hierarchy     |
| OB_Data    | Service Person | RLS            | Service Person | Many → One  | Single           | Inactive | Controlled activation for RLS scenarios                |
| OB_Data    | SO Date        | Calendar       | Date           | Many → One  | Single           | Active   | Time intelligence for Order Booking analysis           |
| SAM_Bridge | Service Person | RLS            | Service Person | Many → One  | Single           | Active   | Enforcing row-level security through bridge table      |

---

## Modeling Notes

* **Calendar table** acts as the common date dimension for both IB and OB datasets
* **SAM_Bridge** is used as an intermediary table to maintain consistent service-person hierarchy
* **Inactive RLS relationships** are intentionally designed to support secure, controlled access using DAX
* **Single-direction filters** are applied to avoid ambiguity and maintain performance

This structure supports **market share analysis, performance tracking, and secure role-based reporting**.

---

## 3. Fact Table

### IB - Data (Fact Table)

## 4. Dimension Tables

### Calendar (Dim Table)
### OB_Data (Dim Table)
### Pump - MALP List (Dim Table)
### RLS (Dim Table)
### SAM_bridge (Dim Table)

---

## 5. Modeling Best Practices Applied

* Surrogate keys used for stable relationships
* Fact table maintained at the lowest required granularity
* Dimension tables kept descriptive and non-redundant
* Unused columns removed to optimize model size and performance

---

## 6. Performance Considerations

To improve performance and scalability:

* Column data types were optimized
* High-cardinality columns were minimized
* Measures were preferred over calculated columns wherever possible

---

## 7. Validation

The data model was validated by:

* Verifying row counts against source data
* Testing cross-filter behavior across visuals
* Ensuring accurate aggregation across dimensions

---

## 8. Outcome

The finalized data model:

* Enabled accurate market share and growth calculations
* Supported flexible slicing by Customer, Sales Person, State, and Year
* Improved dashboard performance and maintainability
* Provided a reliable foundation for advanced DAX measures
Just say 👉 **“Next: DAX Measures”**

