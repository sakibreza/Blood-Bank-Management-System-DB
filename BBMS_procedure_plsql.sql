CREATE OR REPLACE FUNCTION totalDonar 
RETURN number IS 
   total integer := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM Donar; 
    
   RETURN total; 
END; 

SET SERVEROUTPUT ON
DECLARE
    num integer;
    total_rows integer;
   cnt integer;
   res integer;
   p_id integer;
   d_id integer;
   dd_id integer;
   d_name Donar.donar_name%type;
   d_blood Donar.blood_group%type;
   d_place Donar.donar_address%type;
   p_blood Patient.blood_group%type;
   p_place Patient.patient_address%type;
   type don_bl is varray (11) of Donar.blood_group%type; 
   dbl_list don_bl := don_bl(); 

PROCEDURE no_of_donation(d_name IN Donar.donar_name%type,num OUT integer) IS 
BEGIN 
   num := 0;
   cnt := 10001;
   while cnt<=10010
   loop
    select donar_id into d_id
    from Donar where donar_name = d_name; 
    
    select donar_id into dd_id
    from Donate where donate_id = cnt;
    
        if (d_id = dd_id) then
            num := num + 1;
        end if; 
    cnt:=cnt+1; 
   end loop;
END;
 

PROCEDURE no_of_donar_available_for_pat(p_id IN integer,num OUT integer) IS 
BEGIN 
   num := 0;
   cnt := 101;
   while cnt<=110
   loop
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    
    select blood_group into p_blood
    from Patient where patient_id = p_id;
    
        if (d_blood = p_blood) then
            num := num + 1;
        end if; 
    cnt:=cnt+1; 
   end loop;
END;
   
   
PROCEDURE no_of_donar_available(p_blood IN Patient.blood_group%type,num OUT integer) IS 
BEGIN 
   num := 0;
   cnt := 101;
   while cnt<=110
   loop
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    
        if (d_blood = p_blood) then
            num := num + 1;
        end if; 
    cnt:=cnt+1; 
   end loop;
END;

PROCEDURE no_of_donar_available_in_place(p_blood IN Patient.blood_group%type,p_place Patient.patient_address%type,num OUT integer) IS 
BEGIN 
   num := 0;
   cnt := 101;
   while cnt<=110
   loop
    select blood_group into d_blood
    from Donar where donar_id = cnt;
    select donar_address into d_place
    from Donar where donar_id = cnt;
    
        if (d_blood = p_blood and d_place = p_place) then
            num := num + 1;
        end if; 
    cnt:=cnt+1; 
   end loop;
END;

   
BEGIN
   --cursor
   update Donar
   set donar_address = 'Chattogram'
   where donar_address = 'Chittagong';
   if sql%notfound then 
      dbms_output.put_line('no donars address changed'); 
   elsif sql%found then 
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' donars address changed '); 
   end if; 
   
   --array
   num := 1;
   cnt := 10001;
   dbl_list.extend(11);
   while cnt<=10010
   loop
    select donar_id into d_id
    from Donate where donate_id = cnt;
    
    select blood_group into d_blood
    from Donar where donar_id = d_id;
    
    dbl_list(num) := d_blood;
     
    num:=num+1;
    cnt:=cnt+1; 
   end loop;
   --dbms_output.put_line(dbl_list(4));
   
   num := 1;
   cnt := 10001;
   --dbl_list.extend(11);
   while cnt<=10010
   loop
     dbms_output.put_line('Donation id : '||cnt||'  Blood group = '||dbl_list(num));
     
    num:=num+1;
    cnt:=cnt+1; 
   end loop;
    
   dbms_output.put_line('Number of Donar : '||totalDonar());
   p_blood := 'A+';
   p_place := 'Dhaka';
   no_of_donar_available(p_blood,res);
   dbms_output.put_line(' Number of donar available for '||p_blood||' blood :' || res);    
   no_of_donar_available_in_place(p_blood,p_place,res);
   dbms_output.put_line(' Number of donar available for '||p_blood||' blood in '|| p_place || ' : ' || res); 
   p_id := 1001;
   no_of_donar_available_for_pat(p_id,res);
   dbms_output.put_line(' Number of donar available for patient no. '||p_id||' : '||res);
   d_name := 'DA';
   no_of_donation(d_name,res);
   dbms_output.put_line('Number of donation by donar - '||d_name||' : '||res); 
END; 