set serveroutput on 
declare 
f utl_file.file_type;
line varchar(1000);
id donar.donar_id%type;
name donar.donar_name%type;
bgroup donar.blood_group%type;
contact donar.donar_contact_no%type;
place donar.donar_address%type;
begin
f:= utl_file.fopen('BBMS','new_entry.csv','r');
if utl_file.is_open(f) then
utl_file.get_line(f,line,1000);
loop begin
utl_file.get_line(f,line,1000);
if line is null then exit;
end if;
id:= regexp_substr(line,'[^,]+',1,1);
name:= regexp_substr(line,'[^,]+',1,2);
bgroup:= regexp_substr(line,'[^,]+',1,3);
contact:= regexp_substr(line,'[^,]+',1,4);
place:= regexp_substr(line,'[^,]+',1,5);
insert into donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address) values(id,name,bgroup,contact,place);
commit;
exception when no_data_found then exit;
end;
end loop;
end if;
--utl_file_fclose(f);
end;

/
