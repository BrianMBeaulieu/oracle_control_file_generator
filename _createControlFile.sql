set pause off
set pages 0
set echo off
set verify off
set feed off
alter database backup controlfile to 'controlfile.backup' REUSE;
alter database backup controlfile to trace;
select p.spid from v$session s, v$process p where s.paddr = p.addr and s.username = 'SYS';
exit
