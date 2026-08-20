# Windows Admin & IT Troubleshooting Lab

## Overview
Standard operating procedures (SOP) and troubleshooting runbook for Tier-1 IT support incidents, operating system diagnostic workflows, and hardware failure triage.

## Core Diagnostics Checklist
1. **Network Connectivity:** Verify link layer, IP lease (DHCP), and DNS resolution.
2. **Resource Consumption:** Inspect CPU, RAM, and Disk I/O bottlenecks via Task Manager / Resource Monitor.
3. **Event Logs:** Audit critical system and application events in Windows Event Viewer.

## Common Incident Resolutions
* **Issue:** IP Address Conflict / No Internet Access
  * **Resolution:** Execute `ipconfig /release && ipconfig /renew` and flush DNS cache with `ipconfig /flushdns`.
* **Issue:** High Disk Usage (100% utilization)
  * **Resolution:** Identify high-write background processes, check disk health using `chkdsk`, and inspect Windows Search indexing.

---
**Author:** Vladimir Gorretti Liuca Torrez  
**Role:** Junior IT Support & Cloud Enthusiast
