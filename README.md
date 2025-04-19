# sql-ag-failover-automation
Powershell script to automate sql availability group failovers between nodes. Uses DBATools.io module as the base.

Prerequisites:
* Central Management Server with availability group listener names stored in one folder
* DBATools.io powershell module installed
* User running process will need SA permisssions in the database instances

Notes:
* This script uses hardcoded server\instance variables for a primary and a secondary server

Links:
* DBAtools module - https://dbatools.io
