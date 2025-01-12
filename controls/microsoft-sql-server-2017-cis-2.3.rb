# encoding: UTF-8

control "microsoft-sql-server-2017-cis-2.3" do
  title "Ensure 'Cross DB Ownership Chaining' Server Configuration Option is 
set to '0' (Automated)"
  desc "The cross db ownership chaining option controls cross-database ownership
chaining 
across all databases at the instance (or server) level."
  desc "rationale", "When enabled, this option allows a member of the db_owner role in a database to
gain 
access to objects owned by a login in any other database, causing an unnecessary

information disclosure. When required, cross-database ownership chaining should
only be 
enabled for the specific databases requiring it instead of at the instance level
for all 
databases by using the ALTER DATABASE<database_name>SET DB_CHAINING ON command. 

This database option may not be changed on the master, model, or tempdb system 
databases."
  desc "check", "Run the following T-SQL command: 
SELECT name, 
      CAST(value as int) as value_configured, 
      CAST(value_in_use as int) as value_in_use 
FROM sys.configurations 
WHERE name = 'cross db ownership chaining'; 
Both value columns must show 0 to be compliant."
  desc "fix", "Run the following T-SQL command: 
EXECUTE sp_configure 'cross db ownership chaining', 0; 
RECONFIGURE; 
GO"
  desc "default_value", "By default, this option is disabled (0)."
  impact 0.5
  ref 'https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option'
  tag nist: []
  tag severity: "medium"
  tag cis_controls: " 
Controls 
Version 
Control 
IG 1 IG 2 IG 3 
v7 
14.6 Protect Information through Access Control Lists 
 
Protect all information stored on systems with file system network share claims 

application or database specific access control lists. These controls will
enforce the 
principle that only authorized individuals should have access to the information
based 
on their need to access the information as a part of their responsibilities. 
 
 
 
v6 
14.4 Protect Information With Access Control Lists 
 
All information stored on systems shall be protected with file system network 
share claims application or database specific access control lists. These
controls will 
enforce the principle that only authorized individuals should have access to the

information based on their need to access the information as a part of their 
responsibilities. 
 
 
 
"
end