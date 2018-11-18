-- pl/sql commands 

SET SERVEROUTPUT ON
DECLARE
   cnt integer;
   d_name Donar.donar_name%type;
   d_blood Donar.blood_group%type;
   d_place Donar.donar_address%type;
   p_blood Patient.blood_group%type;
   p_place Patient.patient_address%type;
BEGIN

-- given donar id,print name of the donar
   select donar_name into d_name  
   from Donar where donar_id = 101;
   dbms_output.put_line('The name is : ' || d_name);
   
   --exception
   --when others then
    --dbms_output.put_line('invalid id');
    
   dbms_output.put_line('--------------');
   
-- print names of all the donars 
   cnt := 101;
   while cnt<=110
   loop
    select donar_name into d_name
    from Donar where donar_id = cnt;
    dbms_output.put_line('The name is : ' || d_name); 
    cnt:=cnt+1; 
   end loop;
   dbms_output.put_line('--------------');
   
--desired donar for a particular blood group and place    
   cnt := 101;
   while cnt<=110
   loop
    select donar_name into d_name
    from Donar where donar_id = cnt;
    
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    
    select donar_address into d_place
    from Donar where donar_id = cnt;
    
        if (d_blood = 'A+' and d_place = 'Dhaka') then
            dbms_output.put_line('Desired donar : ' || cnt ||' '||d_name||' '||d_blood||' '||d_place);
        end if; 
    cnt:=cnt+1; 
   end loop;
   dbms_output.put_line('--------------');
   
-- donar available for a particular patient (anywhere)   
   select blood_group into p_blood
   from Patient where patient_id = 1002;
   cnt := 101;
   while cnt<=110
   loop
    select donar_name into d_name
    from Donar where donar_id = cnt;
    
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    
    select donar_address into d_place
    from Donar where donar_id = cnt;
    
        if (d_blood = p_blood) then
            dbms_output.put_line('Desired donar : ' || cnt ||' '||d_name||' '||d_blood||' '||d_place);
        end if; 
    cnt:=cnt+1; 
   end loop;
   
    dbms_output.put_line('--------------');
   
-- donar available for a particular patient (in the same place)   
   select blood_group into p_blood
   from Patient where patient_id = 1002;
   
   select patient_address into p_place
   from Patient where patient_id = 1002;
   
   cnt := 101;
   while cnt<=110
   loop
    select donar_name into d_name
    from Donar where donar_id = cnt;
    
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    
    select donar_address into d_place
    from Donar where donar_id = cnt;
    
        if (d_blood = p_blood and d_place = p_place) then
            dbms_output.put_line('Desired donar : ' || cnt ||' '||d_name||' '||d_blood||' '||d_place);
        end if; 
    cnt:=cnt+1; 
   end loop;

 END;
