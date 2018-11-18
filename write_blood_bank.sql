  set serveroutput on
  declare
  f utl_file.file_type;
 num integer;
   cnt integer;
   d_id integer;
   d_blood Donar.blood_group%type;
   type don_bl is varray (11) of BloodBank.blood_bank_address%type; 
   dbl_list don_bl := don_bl();  
  begin
   num := 1;
   cnt := 1;
   dbl_list.extend(11);
   
   FOR cursor1 IN (select distinct(blood_bank_address) as address from bloodbank)
          LOOP
            dbl_list(num) := cursor1.address;
            num:=num+1;
          END LOOP;
   
   while cnt<=num
   loop
        f:= utl_file.fopen('BBMS',concat(to_char(dbl_list(cnt)),'_blood_bank.csv'),'w');
        utl_file.put(f,'id'||','||'name'||','||'place'||','||'contact');
        utl_file.new_line(f);
        for c_record in (select * from bloodbank where blood_bank_address = dbl_list(cnt))
        loop
            utl_file.put(f,c_record.blood_bank_id||','||c_record.blood_bank_name||','||c_record.blood_bank_address||','||c_record.blood_bank_contact_no);
            utl_file.new_line(f);
        end loop;
        utl_file.fclose(f);
        --dbms_output.put_line(dbl_list(cnt));
        cnt:=cnt+1; 
   end loop;
end;