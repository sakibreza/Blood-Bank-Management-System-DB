  set serveroutput on
  declare
  f utl_file.file_type;
 num integer;
   cnt integer;
   d_id integer;
   d_blood Donar.blood_group%type;
   type don_bl is varray (11) of Donar.blood_group%type; 
   dbl_list don_bl := don_bl();  
  begin
   num := 1;
   cnt := 1;
   dbl_list.extend(11);
   
   FOR cursor1 IN (select distinct(blood_group) as blood from donar)
          LOOP
            dbl_list(num) := cursor1.blood;
            num:=num+1;
          END LOOP;
   
   while cnt<=num
   loop
        f:= utl_file.fopen('BBMS',concat(to_char(dbl_list(cnt)),'_donar.csv'),'w');
        utl_file.put(f,'id'||','||'name'||','||'blood'||','||'contact'||','||'place');
        utl_file.new_line(f);
        for c_record in (select donar_id,donar_name,blood_group,donar_contact_no,donar_address from donar where blood_group = dbl_list(cnt))
        loop
            utl_file.put(f,c_record.donar_id||','||c_record.donar_name||','||c_record.blood_group||','||c_record.donar_contact_no||','||c_record.donar_address);
            utl_file.new_line(f);
        end loop;
        utl_file.fclose(f);
        --dbms_output.put_line(dbl_list(cnt));
        cnt:=cnt+1; 
   end loop;
end;